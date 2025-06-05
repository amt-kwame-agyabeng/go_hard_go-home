# Create WAF to block top 10 OWASP attacks
resource "aws_wafv2_web_acl" "waf" {
  name               = local.waf_acl_name
  scope              = "REGIONAL"
  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    sampled_requests_enabled   = true
    metric_name = local.waf_metric_name
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "CommonRules"
      sampled_requests_enabled = true
    }
  }
  tags = local.common_tags
}


# Create security group for Jump Server 
resource "aws_security_group" "sg_jump_server" {
    name        = "${local.name_prefix}-sg_jump_server"
    description = "Security group for Jump Server"
    vpc_id      = var.vpc_id

    tags = merge(local.common_tags,{
      Name = local.jump_server_sg_name
    })

 
    

    # Allow SSH traffic from my IP
    ingress {
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = "tcp"
      cidr_blocks = [local.myip_cidr]
     
    }

    # default outbound traffic
    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }

  
}

# Create Security Group for ALB
resource "aws_security_group" "sg_alb" {
    name        = "${local.name_prefix}-sg_alb"
    description = "Security group for ALB"
    vpc_id      = var.vpc_id

    tags = merge(local.common_tags, {
      Name = local.alb_sg_name
    })



    # Allow HTTP traffic from Internet
    ingress {
      from_port   = var.http_port
      to_port     = var.http_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow HTTPS traffic from Internet
    ingress {
      from_port   = var.https_port
      to_port     = var.https_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      
    }
    
    # Allow SSH traffic from jump server
    ingress {
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_jump_server.id]
  
    }

    # default outbound traffic
    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  

}

# Create Security Group for ECS
resource "aws_security_group" "sg_ecs" {
    name        = "${local.name_prefix}-sg_ecs"
    description = "Security group for ECS"
    vpc_id      = var.vpc_id

    tags = merge(local.common_tags,{
      Name = local.ecs_sg_name
    })

   

    # Allow HTTP traffic from ALB
    ingress {
      from_port   = var.http_port
      to_port     = var.http_port
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_alb.id]
    }

    # Allow HTTPS traffic from ALB
    ingress {
      from_port   = var.https_port
      to_port     = var.https_port
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_alb.id]
    }

    # Allow SSH traffic from jump server
    ingress {
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_jump_server.id]
    }

    
    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow port 8080 (container port)
    ingress {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_alb.id]
    } 

    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }


}

# Create Security Group for RDS
resource "aws_security_group" "sg_rds" {
    name        = "${local.name_prefix}-sg_rds"
    description = "Security group for RDS"
    vpc_id      = var.vpc_id

    tags = merge(local.common_tags,{
      Name = local.rds_sg_name
    })


    # Allows RDS traffic from ECS (Port depends on the RDS engine)
    ingress  {
      from_port   = var.mysql_port
      to_port     = var.mysql_port
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_ecs.id]
   }


    # Allow SSH traffic from jump server
    ingress {
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_jump_server.id]
    }

    # default outbound traffic
    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

  
}

