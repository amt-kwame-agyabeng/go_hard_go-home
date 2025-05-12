# Create a VPC 
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

 tags = merge(local.common_tags, {
  Name = "${local.vpc_name}"

 })

}


# Create a web public subnet in the VPC across two availability zones
resource "aws_subnet" "web_public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index)
  availability_zone       = local.avaliability_zones[count.index]
  map_public_ip_on_launch = true

 tags = merge({
  Name = "${local.web_subnet_name}-${local.avaliability_zones[count.index]}"
  Type = "Public"
 })


  
}

# Create a app private subnet in the VPC across two availability zones
resource "aws_subnet" "app_private_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index + 2)
  availability_zone       = local.avaliability_zones[count.index]
  map_public_ip_on_launch = false

  tags = merge({
  Name = "${local.app_subnet_name}-${local.avaliability_zones[count.index]}"
  Type = "Private"
 })

  
}

# Create a db private subnet in the VPC across two availability zones
resource "aws_subnet" "db_private_subnet" {
  count = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index + 4)
  availability_zone       = local.avaliability_zones[count.index]
  map_public_ip_on_launch = false
  
  tags = merge({
  Name = "${local.db_subnet_name}-${local.avaliability_zones[count.index]}"
  Type = "Private"
 })
}


# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.igw_name}"
    }

  )
  
}

# Create the elastic ip for the nat gateway
resource "aws_eip" "nat_eip" {

  depends_on = [aws_internet_gateway.igw]


   tags = merge(
    local.common_tags,
    {
      Name = "${local.nat_eip_name}"
    }

  )
  
}



# Create the nat gateway 
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.web_public_subnet[0].id
  tags = merge(
    local.common_tags,
    {
      Name = "${local.ngw_name}"
    }

  )
  
}

# Create a route table for the web (public) subnets
resource "aws_route_table" "web_public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.public_rtb_name}"
    }

  )
  
}

# Create a route table for the app (private) subnets
resource "aws_route_table" "app_private_rt" {
  count = length(local.avaliability_zones)
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

   tags = merge(
    local.common_tags,
    {
      Name = "${local.private_rtb_name}"
    }

  )
}



# Associate the public subnets with the public route table
resource "aws_route_table_association" "web_public_rt_association" {
  count = 2
  subnet_id      = aws_subnet.web_public_subnet[count.index].id
  route_table_id = aws_route_table.web_public_rt.id

}

# Associate the private subnets with the private route table
resource "aws_route_table_association" "app_private_rt_association" {
  count = 2
  subnet_id      = aws_subnet.app_private_subnet[count.index].id
  route_table_id = aws_route_table.app_private_rt[count.index].id

 
}

# Associate the database subnets with the private route table
resource "aws_route_table_association" "db_private_rt_association" {
  count          = 2
  subnet_id      = aws_subnet.db_private_subnet[count.index].id
  route_table_id = aws_route_table.app_private_rt[count.index].id

}

# Tag VPC Default Security as "Do not use"
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Default SG: Do not use"
  }
}

# Tag Default Route Table as "Do not Use"
resource "aws_ec2_tag" "default_rtb" {
  resource_id = aws_vpc.vpc.default_route_table_id
  key = "Name"
  value = "Default Route Table: Do not use" 
  
}
