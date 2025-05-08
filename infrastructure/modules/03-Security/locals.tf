# local variable for naming conventions
locals {
  name_prefix = "${var.owner}-${var.environment}-${var.region}"
}

locals {
  common_tags = {
    Owner = var.owner
    Environment = var.environment
    Region = var.region
  }
}


locals {
  jump_server_sg_name = "${local.name_prefix}-${var.jump_server_sg_name}"
  alb_sg_name = "${local.name_prefix}-${var.alb_sg_name}"
  ecs_sg_name = "${local.name_prefix}-${var.ecs_sg_name}"
  rds_sg_name = "${local.name_prefix}-${var.rds_sg_name}"
  waf_acl_name = "${local.name_prefix}-${var.waf_acl_name}"
  waf_metric_name = "${local.name_prefix}-tier3-waf-metric"

  
}

# get my ip address
locals {
  myip = trimspace(data.http.myip.response_body)
  ip_parts = split(".", local.myip)
  myip_cidr = "${local.ip_parts[0]}.${local.ip_parts[1]}.0.0/16"
}