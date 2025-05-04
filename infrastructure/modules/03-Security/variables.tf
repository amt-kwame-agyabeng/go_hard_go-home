variable "vpc" {
    description = "The name of the VPC to pass to the security module"
    type        = string  
    
}


variable "owner" {
    description = "The owner of the VPC to pass to the security module"
    type        = string
  
}

variable "environment" {
    description = "The environment of the VPC to pass to the security module"
    type        = string
  
}

variable "region" {
    description = "The region of the VPC to pass to the security module"
    type        = string
  
}

variable "vpc_id" {
    description = "The ID of the VPC to pass to the security module"
    type        = string
  
}
