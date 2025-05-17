# Create Jump Server
resource "aws_instance" "jump_server" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    subnet_id = local.jumpbox_subnet_id
    vpc_security_group_ids = [data.aws_ssm_parameter.sg_jump_server_id.value]
    iam_instance_profile = data.aws_iam_instance_profile.jump_server_profile.name

    lifecycle {
      ignore_changes = [ 
        ami,
        security_groups,
        tags,
        user_data,
        subnet_id,
       ]
    }

    tags = merge(local.common_tags,{
        Name = local.jump_server_name
    })
  
}

# Add service discovery DNS namespace
resource "aws_service_discovery_private_dns_namespace" "ecs" {
  name        = "${local.name_prefix}.local"
  description = "Service Discovery Namespace for ECS"
  vpc = data.aws_ssm_parameter.vpc_id.value

  tags = merge(local.common_tags,{
    Name = "${local.name_prefix}.local"
  })

  lifecycle {
    ignore_changes = [ 
      name,
      description,
      vpc
     ]
  }

}


# Create Service Discovery Service for ECS
resource "aws_service_discovery_service" "app" {
  name = local.ecs_service_name

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.ecs.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

  tags = merge(local.common_tags, {
    Name        = local.ecs_service_name
  })

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name,
      description
    ]
  }
}


# Create the ALB
resource "aws_lb" "alb" {
  name               = local.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.sg_alb_id.value]
  subnets            = split(",", data.aws_ssm_parameter.web_subnet_ids.value)
  drop_invalid_header_fields = true
  enable_deletion_protection = var.environment == "prod" ? true : false

  tags = merge(local.common_tags, {
    Name = local.alb_name
  })
}

#HTTP Listener (handles HTTP traffic only)
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

# Target Group for ALB
resource "aws_lb_target_group" "app" {
  name        = local.target_group_name
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 5
    matcher             = "200-399"
  }

  lifecycle {
    ignore_changes = [
      name,
      port,
      protocol,
      target_type,
      vpc_id
    ]
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = local.target_group_name
  })
}


# Associate WAF with ALB
resource "aws_wafv2_web_acl_association" "waf_alb_association" {
  resource_arn = aws_lb.alb.arn
  web_acl_arn  = data.aws_ssm_parameter.waf_acl_arn.value

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      web_acl_arn,
      resource_arn
    ]
  }
}


# Create IAM Role for ECS Task Execution
data "aws_iam_policy_document" "ecs_task_execution_role" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:ListImages",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
    ]
  }
}


# Create ECR Repository
resource "aws_ecr_repository" "ecr_repo" {
    name = local.ecr_repo_name
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
    tags = merge(local.common_tags, {
        Name = local.ecr_repo_name
    })
}




# Create lifecycle policy for unused ECR images in the repo
resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.ecr_repo.name
  policy     = file("${path.root}/policies/ecr-lifecycle-policy.json")

  depends_on = [ aws_ecr_repository.ecr_repo ]
}


# Create Lifecycle Policy for unused ECR Images in the repo
resource "aws_ecr_lifecycle_policy" "repo_policy" {
    repository = aws_ecr_repository.ecr_repo.name
    policy = file("${path.root}/Policies/ecr-lifecycle-policy.json")

    depends_on = [aws_ecr_repository.ecr_repo]
}

 
# Create ECS Cluster
resource "aws_ecs_cluster" "ecs" {
  name = local.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }


  tags = merge(local.common_tags, {
    Name = "${local.ecs_cluster_name}"
  })


}

# Create Cloudwatch Log Group for ECS App Logs
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/app-logs"
  retention_in_days = 7
}



# Create ECS Task Definition
resource "aws_ecs_task_definition" "ecs_task" {
  family                   = local.ecs_task_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 2048
  memory                   = 4096
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = data.aws_iam_role.ecs_task_role.arn
  container_definitions    = local.container_definitions

  tags = merge(local.common_tags, {
    Name = "${local.ecs_task_name}"
  })
}


# # Create Autoscaling Group for ECS Cluster
# resource "aws_autoscaling_group" "ecs_asg" {
#     name = local.asg_name
#     max_size            = 6
#     min_size            = 2
#     desired_capacity    = 2
#     vpc_zone_identifier = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
#     health_check_type   = "ELB"
#     target_group_arns   = [aws_lb_target_group.app.arn]

#     lifecycle {
#         ignore_changes = [load_balancer]
#     }
# }

# ECS Service
resource "aws_ecs_service" "service" {
  name            = local.ecs_service_name
  cluster         = aws_ecs_cluster.ecs.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds  = 60

  network_configuration {
    security_groups   = [data.aws_ssm_parameter.sg_ecs_id.value]
    subnets           = split(",", data.aws_ssm_parameter.web_subnet_ids.value)
    assign_public_ip  = false
  }

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "app-container"
    container_port   = 8080
  }

  service_registries {
    registry_arn = aws_service_discovery_service.app.arn
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  depends_on = [aws_lb.alb, aws_lb_listener.http_listener]
}
