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

variable "instance_type" {
  description = "The instance type"
  type        = string
}

variable "container_port" {
  description = "The container port"
  type        = number
  
}

variable "alb_https_listener_port" {
  description = "The ALB HTTPS listener port"
  type        = number
  
}

# # Variable for wildcard Domain Name
# variable "wildcard_domain_name" {
#   description = "Wildcard domain name for ALB"
#   type        = string
# }