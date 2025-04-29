module "s3_storage" {
    source = "./modules/01-Storage"
    bucket_name = var.bucket_name
  
}
