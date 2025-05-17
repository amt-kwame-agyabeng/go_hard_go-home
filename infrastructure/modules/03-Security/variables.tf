variable "vpc" {
    description = "The name of the VPC "
    type        = string  
    
}


variable "owner" {
    description = "The owner of the resources"
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

variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
  
}


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
    type = number
  
}
variable "http_port" {
    description = "The port to use for HTTP"
    type = number
  
}
variable "https_port" {
    description = "The port to use for HTTPS"
    type = number
  
}

variable "mysql_port" {
    description = "The port to use for MySQL"
    type = number
  
}
