# vpc
output "vpc_id" {
    value = aws_vpc.vpc.id
}



# web_public_subnet_ids
output "web_public_subnet_ids" {
    value = [for subnet in aws_subnet.web_public_subnet : subnet.id] 
}

#  app_private_subnet_ids
output "app_private_subnet_ids" {
    value  = [for subnet in aws_subnet.app_private_subnet : subnet.id]
}

# db_private_subnet_ids
output "db_private_subnet_ids" {
    value = [for subnet in aws_subnet.db_private_subnet : subnet.id]
}

output "igw_id" {
    value = aws_internet_gateway.igw.id
}

output "nat_gw_id" {
    value = [for nat_gw in aws_nat_gateway.nat_gw : nat_gw.id]
  
}

output "nat_eip_id" {
    value =[for eip in aws_eip.nat_eip : eip.id]
  
}
output "web_public_rt_id" {
    value = aws_route_table.web_public_rt.id
  
}

output "app_private_rt_id" {
    value = [for rt in aws_route_table.app_private_rt : rt.id]
  
}

output "db_private_rt_id" {
    value = [for rt in aws_route_table.db_private_rt : rt.id]
  
}

output "web_public_rt_association" {
    value = [for association in aws_route_table_association.web_public_rt_association : association.id]
  
}


output "app_private_rt_association" {
    value = [for association in aws_route_table_association.app_private_rt_association : association.id]
  
}

output "db_private_rt_association" {
    value = [for association in aws_route_table_association.db_private_rt_association : association.id]
  
}
