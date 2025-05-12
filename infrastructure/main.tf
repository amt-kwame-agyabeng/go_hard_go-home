module "logging_bucket" {
  source      = "./modules/01-Storage"
  bucket_name = var.bucket_name
  owner = var.owner
  environment = var.environment
  region = var.region 

}

module "iam" {
  source                    = "./modules/04-IAM"
  owner                     = var.owner
  environment               = var.environment
  region                    = var.region
  ecs_task_policy_arns      = var.ecs_task_policy_arns
  ssm_policy_arns           = var.ssm_policy_arns
  ecs_execution_policy_arns = var.ecs_execution_policy_arns
  s3_policy_arns            = var.s3_policy_arns

}


module "networking" {
  source           = "./modules/02-Networking"
  owner            = var.owner
  environment      = var.environment
  region           = var.region
  vpc              = var.vpc_name
  vpc_cidr         = var.vpc_cidr
  ngw_name         = var.ngw_name
  igw_name         = var.igw_name
  nat_eip_name     = var.nat_eip_name
  private_rtb_name = var.private_rtb_name
  public_rtb_name  = var.public_rtb_name
  web_subnet_name  = var.web_subnet_name
  app_subnet_name  = var.app_subnet_name
  db_subnet_name   = var.db_subnet_name

  depends_on = [module.iam, module.s3_storage]


}

module "security" {
  source              = "./modules/03-Security"
  vpc_id              = module.networking.vpc_id
  owner               = var.owner
  environment         = var.environment
  region              = var.region
  vpc                 = var.vpc_name
  jump_server_sg_name = var.jump_server_sg_name
  alb_sg_name         = var.alb_sg_name
  rds_sg_name         = var.rds_sg_name
  ecs_sg_name         = var.ecs_sg_name
  ssh_port            = var.ssh_port
  http_port           = var.http_port
  https_port          = var.https_port
  mysql_port          = var.mysql_port
  waf_acl_name        = var.waf_acl_name

  depends_on = [module.networking, module.iam]


}

