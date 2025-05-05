variable "owner" {
    description = "The owner of the VPC to pass to the security module"
    type        = string
  
}

variable "environment" {
    description = "The environment of the VPC to pass to the security module"
    type        = string
  
}

# S3 bucket
variable "bucket_name" {
  description = "the name of the s3 bucket created"
  type        = string
 
}
