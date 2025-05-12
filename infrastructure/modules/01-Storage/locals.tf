# Create a local variable for naming conventions
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
  bucket_name = "${local.name_prefix}-${var.bucket_name}"
}