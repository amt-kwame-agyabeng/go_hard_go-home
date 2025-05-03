output "sg_jump_server_id" {
    value = aws_security_group.sg_jump_server.id
  
}


output "sg_alb_id" {
    value = aws_security_group.sg_alb.id
  
}

output "sg_rds_id" {
    value = aws_security_group.sg_rds.id
  
}

output "sg_ecs_id" {
    value = aws_security_group.sg_ecs.id
  
}

