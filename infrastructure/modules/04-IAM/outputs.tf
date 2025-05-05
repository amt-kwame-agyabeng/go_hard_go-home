output "s3_loggging_access_role_arn" {
    value = aws_iam_role.s3_logging_access_role.arn
  
}
output "ecs_execution_role_arn" {
    value = aws_iam_role.ecs_execution_role.arn
  
}

output "ecs_task_role_arn" {
    value = aws_iam_role.ecs_task_role.arn
  
}
output "ecs_task_execution_role_arn" {
    value = aws_iam_role.ecs_task_execution_role.arn
  
}

output "ssm_instance_role_arn" {
    value = aws_iam_role.ssm_instance_role.arn
  
}

output "ssm_instance_profile_arn" {
    value = aws_iam_instance_profile.ssm_instance_profile.arn
  
}