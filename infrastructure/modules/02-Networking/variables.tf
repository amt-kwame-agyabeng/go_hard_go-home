

variable "owner" {
    description = "The owner of the resources"
    type        = string
  
}

variable "environment" {
    description = "The environment name "
  
}

variable "region" {
    description = "AWS region to deploy resources"
    type        = string
  
}

#---------------------------
# Networking variables
#---------------------------

variable "vpc" {
    description = "The name of the VPC "
    type        = string
    
    
}

variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
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

