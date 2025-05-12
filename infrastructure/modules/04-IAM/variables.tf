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


variable "ssm_policy_arns" {
    description = "The ARNs of the policies to attach to the SSM role"
    type        = list(string)


}
variable "ecs_task_policy_arns" {
    description = "The ARNs of the policies to attach to the ECS task role"
    type        = list(string)
  
}

variable "ecs_execution_policy_arns" {
    description = "The ARNs of the policies to attach to the ECS execution role"
    type        = list(string)
  
}
# variable "ecs_task_execution_policy_arns" {
#     description = "The ARNs of the policies to attach to the ECS task execution role"
#     type        = list(string)
  
# }
variable "s3_policy_arns" {
    description = "The ARNs of the policies to attach to the S3 role"
    type        = list(string)
  
}