# local variable for naming conventions
locals {
  name_prefix = "${var.owner}-${var.environment}-${var.region}"
}


# Create a local variable for common tags
locals {
  common_tags = {
    Owner = var.owner
    Environment = var.environment
    Region = var.region
  }
}

 # Create a local variable for resources name
locals {
  vpc_name = "${local.name_prefix}-${var.vpc}"
  igw_name = "${local.name_prefix}-${var.igw_name}"
  web_subnet_name = "${local.name_prefix}-${var.web_subnet_name}"
  app_subnet_name = "${local.name_prefix}-${var.app_subnet_name}"
  db_subnet_name = "${local.name_prefix}-${var.db_subnet_name}"
  ngw_name = "${local.name_prefix}-${var.ngw_name}"
  nat_eip_name = "${local.name_prefix}-${var.nat_eip_name}"
  public_rtb_name = "${local.name_prefix}-${var.public_rtb_name}"
  private_rtb_name = "${local.name_prefix}-${var.private_rtb_name}"
}

locals {
  avaliability_zones = ["us-east-1a", "us-east-1b"]
}