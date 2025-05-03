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
  security_group_name = "${local.name_prefix}-${var.vpc}"
}


locals {
  myip = trimspace(data.http.myip.response_body)
  ip_parts = split(".", local.myip)
  myip_cidr = "${local.ip_parts[0]}.${local.ip_parts[1]}.0.0/16"
}