variable "owner" {
  description = "The owner of the project"
  type        = string

}

variable "environment" {
  description = "The environment of the project"
  type        = string

}

variable "region" {
  description = "The region of your VPC"
  type        = string

}



#---------------------
#Variables for Storage modules
#---------------------

variable "bucket_name" {
  description = "the name of the s3 bucket created"
  type        = string

}

#---------------------
#Variables for Network modules
#---------------------

variable "vpc_name" {
  description = "The name of the VPC "
  type        = string

}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string

}
  


variable "igw_name" {
  description = "The name of the Internet Gateway"
  type        = string

}

variable "ngw_name" {
  description = "The name of the NAT Gateway"
  type        = string

}

variable "web_subnet_name" {
  description = "The name of the public subnet"
  type        = string

}

variable "app_subnet_name" {
  description = "The name of the private subnet"
  type        = string

}

variable "db_subnet_name" {
  description = "The name of the private subnet"
  type        = string

}

variable "nat_eip_name" {
  description = "The EIP of the NAT Gateway"
  type        = string

}

variable "public_rtb_name" {
  description = "The name of the public route table"
  type        = string

}

variable "private_rtb_name" {
  description = "The name of the private route table"
  type        = string

}

#-------------------------
# Variables for Security
#-------------------------

variable "jump_server_sg_name" {
  description = "The name of the jump server security group"
  type        = string

}

variable "alb_sg_name" {
  description = "The name of the ALB security group"
  type        = string

}

variable "ecs_sg_name" {
  description = "The name of the ECS security group"
  type        = string

}

variable "rds_sg_name" {
  description = "The name of the RDS security group"
  type        = string

}

variable "waf_acl_name" {
  description = "The name of the WAF ACL"
  type        = string

}

variable "ssh_port" {
  description = "The port to use for SSH"
  type        = number

}
variable "http_port" {
  description = "The port to use for HTTP"
  type        = number

}
variable "https_port" {
  description = "The port to use for HTTPS"
  type        = number

}

variable "mysql_port" {
  description = "The port to use for MySQL"
  type        = number

}


