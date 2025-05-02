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
  vpc_name = "${local.name_prefix}-${var.vpc}"

}

locals {
  avaliability_zones = ["us-east-1a", "us-east-1b"]
}