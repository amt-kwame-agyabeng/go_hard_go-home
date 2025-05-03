output "bucket_name" {
    value = module.s3_storage.bucket_name 
}

output "vpc_id" {
    value = module.networking.vpc_id
}



# web_public_subnet_ids
output "web_public_subnet_ids" {
    value = module.networking.web_public_subnet_ids
}

#  app_private_subnet_ids
output "app_private_subnet_ids" {
    value = module.networking.app_private_subnet_ids
}

# db_private_subnet_ids
output "db_private_subnet_ids" {
    value = module.networking.db_private_subnet_ids
}

output "igw_id" {
    value = module.networking.igw_id
}

output "nat_gw_id" {
    value = module.networking.nat_gw_id
  
}

output "nat_eip_id" {
    value = module.networking.nat_eip_id
  
}
output "web_public_rt_id" {
    value = module.networking.web_public_rt_id
  
}

output "app_private_rt_id" {
    value = module.networking.app_private_rt_id
  
}

output "web_public_rt_association" {
    value = module.networking.web_public_rt_association
  
}


output "app_private_rt_association" {
    value = module.networking.app_private_rt_association
  
}

output "db_private_rt_association" {
    value = module.networking.db_private_rt_association
  
}


output "sg_jump_server_id" {
    value = module.security.sg_jump_server_id
}


output "sg_alb_id" {
    value = module.security.sg_alb_id
  
}

output "sg_rds_id" {
    value = module.security.sg_rds_id
  
}

output "sg_ecs_id" {
    value = module.security.sg_ecs_id
  
}
