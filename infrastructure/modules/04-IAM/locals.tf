locals {
  name_prefix = "${var.owner}-${var.environment}"
}

locals {
    common_tags = {
        Owner = var.owner
        Environment = var.environment
    
    }
}

locals {
    ssm_role_name = "${local.name_prefix}-tier3-ssm-role"
    ssm_profile_name = "${local.name_prefix}-tier3-ssm-profile"
    ecs_task_role_name = "${local.name_prefix}-tier3-ecs-task-role"
    ecs_execution_role_name = "${local.name_prefix}-tier3-ecs-execution-role"
    ecs_task_execution_role_name = "${local.name_prefix}-tier3-ecs-task-execution-role"
    s3_role_name = "${local.name_prefix}-tier3-s3-role"
}