data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
  
}

# Get IAM instance profile for Jump Server
data "aws_iam_instance_profile" "jump_server_profile" {
  name = "${local.name_prefix}-tier3-ssm-profile"
}




# Get IAM roles for ECS tasks
data "aws_iam_role" "ecs_task_role" {
  name = "${local.name_prefix}-tier3-ecs-task-role"
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "${local.name_prefix}-tier3-ecs-task-execution-role"
}

# Retrieve VPC ID from SSM Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.environment}/vpc/id"
}



# Get SSM parameters from the network module
data "aws_ssm_parameter" "sg_jump_server_id" {
  name  = "/${var.environment}/sg_jump_server_id"
  
}

data "aws_ssm_parameter" "web_subnet_ids" {
  name  = "/${var.environment}/web_subnet_ids"
}

data "aws_ssm_parameter" "app_subnet_ids" {
  name  = "/${var.environment}/app_subnet_ids"
  
}

data "aws_ssm_parameter" "sg_ecs_id" {
  name  = "/${var.environment}/sg_ecs_id"
  
}


# Retrieve JumpBox Subnet from SSM Parameter Store
data "aws_ssm_parameter" "jumpbox_subnet" {
  name  = "/${var.environment}/jumpbox_subnet"
}

# Retrieve ALB SG ID from SSM Parameter Store
data "aws_ssm_parameter" "sg_alb_id" {
 name  = "/${var.environment}/sg_alb_id"
  
}

# Fetch WAF ACL ARN from SSM Parameter Store
data "aws_ssm_parameter" "waf_acl_arn" {
    name  = "/${var.environment}/waf-acl/arn"
}

# # Get ACM Certificate
# data "aws_acm_certificate" "acm_cert" {
#   domain   = var.wildcard_domain_name
#   statuses = ["ISSUED"]
#   types    = ["AMAZON_ISSUED"]
# }