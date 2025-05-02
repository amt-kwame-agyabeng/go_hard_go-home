# Create a VPC 
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${local.name_prefix}-vpc"
  }

}


# Create a web public subnet in the VPC across two availability zones
resource "aws_subnet" "web_public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index)
  availability_zone       = local.avaliability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}-web-public-subnet-${local.avaliability_zones[count.index]}"
  }

  
}

# Create a app private subnet in the VPC across two availability zones
resource "aws_subnet" "app_private_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index + 2)
  availability_zone       = local.avaliability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${local.name_prefix}-app-private-subnet-${local.avaliability_zones[count.index]}"

  }
}

# Create a db private subnet in the VPC across two availability zones
resource "aws_subnet" "db_private_subnet" {
  count = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index + 4)
  availability_zone       = local.avaliability_zones[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${local.name_prefix}-db-private-subnet-${local.avaliability_zones[count.index]}"

  }
}


# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.name_prefix}-igw"
  }
  
}

# Create the elastic ip for the nat gateway
resource "aws_eip" "nat_eip" {
  count      = 2
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "${local.name_prefix}-nat-eip-${local.avaliability_zones[count.index]}"
    
  }
}

# Create the nat gateway 
resource "aws_nat_gateway" "nat_gw" {
  count         = 2
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.web_public_subnet[count.index].id

  tags = {
    Name = "${local.name_prefix}-nat-gw-${local.avaliability_zones[count.index]}"
    
  }
  
}

# Create a route table for the web (public) subnets
resource "aws_route_table" "web_public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.name_prefix}-web-public-rt"
  }
  
}

# Create a route table for the app (private) subnets
resource "aws_route_table" "app_private_rt" {
  count = length(local.avaliability_zones)
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw[count.index].id
  }

  tags = {
    Name = "${local.name_prefix}-app-private-rt-${local.avaliability_zones[count.index]}"
  }
  
}

# Create a route table for the database (private) subnets
resource "aws_route_table" "db_private_rt" {
  count = length(local.avaliability_zones)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.name_prefix}-db-private-rt-${local.avaliability_zones[count.index]}"
  }
  
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
  route_table_id = aws_route_table.db_private_rt[count.index].id

}

