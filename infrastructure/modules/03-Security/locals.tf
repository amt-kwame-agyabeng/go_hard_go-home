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