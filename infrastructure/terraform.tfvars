
#-----------------------
# General variables
#-----------------------
owner       = "devkwame"
environment = "dev"
region      = "us-east-2"

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


#------------------------
# IAM variables
#------------------------

# SSM Policy ARNS
ssm_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
]

# ECS Task Policy ARNS
ecs_task_policy_arns = [
  "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
]

# ECS Execution Policy ARNS
ecs_execution_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
]



# S3 Managed Policy ARNs
s3_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonS3FullAccess"
]

#------------------------
# Compute variables
#------------------------

instance_type = "t2.micro"
container_port = 3000
alb_https_listener_port = 443
# wildcard_domain_name = "dev-wildcard-domain-name.com"
