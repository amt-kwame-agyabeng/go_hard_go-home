module "s3_storage" {
    source = "./modules/01-Storage"
    bucket_name = var.bucket_name
  
}

module "networking" {
    source = "./modules/02-Networking"
    owner = var.owner
    environment = var.environment 
    region = var.region
    vpc = var.vpc_name
  
}