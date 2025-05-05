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
    s3_logging_access_name = "${local.name_prefix}-s3-logging-access"
    s3_logging_access_policy_name = "${local.name_prefix}-s3-logging-access-policy"
    
 
}