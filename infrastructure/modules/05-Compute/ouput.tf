output "jump_server_id" {
    description = "ID of Jump Server"
    value = aws_instance.jump_server.id
  
}

output "jump_server_public_ip" {
    description = "Public IP of Jump Server"
    value = aws_instance.jump_server.public_ip
  
}

output "ecr_repo_url" {
    description = "ECR Repo URL"
    value = aws_ecr_repository.ecr_repo.repository_url
  
}

output "ecs_cluster_name" {
    description = "ECS Cluster Name"
    value = aws_ecs_cluster.ecs.name
}

output "ecs_cluster_id" {
    description = "ECS Cluster ID"
    value = aws_ecs_cluster.ecs.id
  
}

output "ecs_service_id" {
    description = "ECS Service ID"
    value = aws_ecs_service.service.id
  
}

output "ecs_task_definition_arn" {
    description = "ECS Task Definition ARN"
    value = aws_ecs_task_definition.ecs_task.arn
  
}

output "ecs_task_definition_family" {
    description = "ECS Task Definition Family"
    value = aws_ecs_task_definition.ecs_task.family
  
}