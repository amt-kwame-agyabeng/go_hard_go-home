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

module "security" {
    source = "./modules/03-Security"
    vpc_id = module.networking.vpc_id
    owner = var.owner  
    environment = var.environment
    region = var.region
    vpc = var.vpc_name
  
}