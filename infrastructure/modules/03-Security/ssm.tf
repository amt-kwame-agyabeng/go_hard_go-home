# store jump server  security group id
resource "aws_ssm_parameter" "sg_jump_server_id" {
    name  = "/${var.environment}/sg_jump_server_id"
    type  = "SecureString"
    value = aws_security_group.sg_jump_server.id
}

# store ALB security group id
resource "aws_ssm_parameter" "sg_alb_id" {
    name  = "/${var.environment}/sg_alb_id"
    type  = "SecureString"
    value = aws_security_group.sg_alb.id
}

# store RDS security group id
resource "aws_ssm_parameter" "sg_rds_id" {
    name  = "/${var.environment}/sg_rds_id"
    type  = "SecureString"
    value = aws_security_group.sg_rds.id
}

# store ECS security group id
resource "aws_ssm_parameter" "sg_ecs_id" {
    name  = "/${var.environment}/sg_ecs_id"
    type  = "SecureString"
    value = aws_security_group.sg_ecs.id
}

# store WAF ACL ARN in parameter store
resource "aws_ssm_parameter" "waf_acl_arn" {
  name  = "/${var.environment}/waf-acl/arn"
  type  = "SecureString"
  value = aws_wafv2_web_acl.waf.arn
}