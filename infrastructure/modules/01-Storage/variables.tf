# S3 bucket
variable "bucket_name" {
  description = "the name of the s3 bucket created"
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
