# store vpc name
resource "aws_ssm_parameter" "vpc" {
  name  = "/${var.environment}/vpc/name"
  type  = "String"
  value = local.vpc_name
}

# store vpc id
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.environment}/vpc/id"
  type  = "String"
  value = aws_vpc.vpc.id
}

# store web subnet ids
resource "aws_ssm_parameter" "web_subnet_ids" {
  name  = "/${var.environment}/web_subnet_ids"
  type  = "String"
  value = join(",", aws_subnet.web_public_subnet[*].id)
}

# store app subnet ids
resource "aws_ssm_parameter" "app_subnet_ids" {
  name  = "/${var.environment}/app_subnet_ids"
  type  = "String"
  value = join(",", aws_subnet.app_private_subnet[*].id)
}

# store igw id
resource "aws_ssm_parameter" "igw_id" {
  name  = "/${var.environment}/igw_id"
  type  = "String"
  value = aws_internet_gateway.igw.id
}

# store nat gw id
resource "aws_ssm_parameter" "nat_gw_id" {
  name  = "/${var.environment}/nat_gw_id"
  type  = "StringList"
  value = join(",", aws_nat_gateway.nat_gw[*].id)
}

# store elastic ip
resource "aws_ssm_parameter" "nat_eip_id" {
  name  = "/${var.environment}/nat_eip_id"
  type  = "StringList"
  value = join(",", aws_eip.nat_eip[*].id)
}

# web rtb id
resource "aws_ssm_parameter" "web_public_rt" {
  name  = "/${var.environment}/web_public_rt"
  type  = "String"
  value = aws_route_table.web_public_rt.id
}

# app rtb id
resource "aws_ssm_parameter" "app_private_rt" {
  name  = "/${var.environment}/app_private_rt"
  type  = "String"
  value = join(",", aws_route_table.app_private_rt[*].id)
}

#db rtb id
resource "aws_ssm_parameter" "db_private_rt" {
  name  = "/${var.environment}/db_private_rt"
  type  = "String"
  value = join(",", aws_route_table.db_private_rt[*].id)
}

# web rtb association id
resource "aws_ssm_parameter" "web_public_rt_association" {
  name  = "/${var.environment}/web_public_rt_association"
  type  = "String"
  value = join(",", aws_route_table_association.web_public_rt_association[*].id)
}
  
# app rtb association id
resource "aws_ssm_parameter" "app_private_rt_association" {
  name  = "/${var.environment}/app_private_rt_association"
  type  = "String"
  value = join(",", aws_route_table_association.app_private_rt_association[*].id)
}