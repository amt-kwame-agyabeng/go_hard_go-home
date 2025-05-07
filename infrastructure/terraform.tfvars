
#-----------------------
# General variables
#-----------------------
owner       = "devkwame"
environment = "dev"
region      = "us-east-1"

#----------------------
# Storage variables
#----------------------
bucket_name = "tier3-bucket"


#------------------------
# Networking variables
#------------------------
vpc_cidr         = "10.0.0.0/16"
vpc_name         = "tier3-vpc"
ngw_name         = "tier3-ngw"
igw_name         = "tier3-igw"
nat_eip_name     = "tier3-eip"
private_rtb_name = "tier3-private_rtb"
public_rtb_name  = "tier3-public-rtb"
web_subnet_name  = "tier3-web-subnet"
app_subnet_name  = "tier3-app-subnet"
db_subnet_name   = "tier3-db-subnet"


#------------------------
# Security variables
#------------------------
jump_server_sg_name = "tier3-jump_server_sg"
alb_sg_name         = "tier3-alb-sg"
ecs_sg_name         = "tier3-ecs-sg"
waf_acl_name        = "tier3-waf-acl"
rds_sg_name         = "tier3-rds-sg"
http_port           = 80
https_port          = 443
ssh_port            = 22
mysql_port          = 3306
