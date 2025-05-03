# store jump server  security group id
resource "aws_ssm_parameter" "sg_jump_server_id" {
    name  = "/${var.environment}/sg_jump_server_id"
    type  = "String"
    value = aws_security_group.sg_jump_server.id
}

# store ALB security group id
resource "aws_ssm_parameter" "sg_alb_id" {
    name  = "/${var.environment}/sg_alb_id"
    type  = "String"
    value = aws_security_group.sg_alb.id
}

# store RDS security group id
resource "aws_ssm_parameter" "sg_rds_id" {
    name  = "/${var.environment}/sg_rds_id"
    type  = "String"
    value = aws_security_group.sg_rds.id
}

# store ECS security group id
resource "aws_ssm_parameter" "sg_ecs_id" {
    name  = "/${var.environment}/sg_ecs_id"
    type  = "String"
    value = aws_security_group.sg_ecs.id
}
    