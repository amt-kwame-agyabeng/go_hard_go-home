# Create security group for Jump Server 
resource "aws_security_group" "sg_jump_server" {
    name        = "${local.name_prefix}-sg_jump_server"
    description = "Security group for Jump Server"
    vpc_id      = var.vpc_id


    tags = {
      Name = "${local.name_prefix}-sg_jump_server"
  
      
    }

    # Allow SSH traffic from my IP
    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [local.myip_cidr]
     
    }

    # default outbound traffic
    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }

  
}

# Create Security Group for ALB
resource "aws_security_group" "sg_alb" {
    name        = "${local.name_prefix}-sg_alb"
    description = "Security group for ALB"
    vpc_id      = var.vpc_id

    tags = {
      Name = "${local.name_prefix}-sg_alb"
   
    }


    # Allow HTTP traffic from Internet
    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow HTTPS traffic from Internet
    ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      
    }
    
    # Allow SSH traffic from jump server
    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_jump_server.id]
  
    }

    # default outbound traffic
    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  

}

# Create Security Group for ECS
resource "aws_security_group" "sg_ecs" {
    name        = "${local.name_prefix}-sg_ecs"
    description = "Security group for ECS"
    vpc_id      = var.vpc_id

    tags = {
      Name = "${local.name_prefix}-sg_ecs"
 
    }


    # Allow HTTP traffic from ALB
    ingress {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_alb.id]
    }

    # Allow HTTPS traffic from ALB
    ingress {
      from_port   = 8443
      to_port     = 8443
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_alb.id]
    }

    # Allow SSH traffic from jump server
    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_jump_server.id]
    }

    
    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

}

# Create Security Group for RDS
resource "aws_security_group" "sg_rds" {
    name        = "${local.name_prefix}-sg_rds"
    description = "Security group for RDS"
    vpc_id      = var.vpc_id

    tags = {
      Name = "${local.name_prefix}-sg_rds"
 
    }


    # Allows RDS traffic from ECS (Port depends on the RDS engine)
    ingress  {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_ecs.id]
   }


    # Allow SSH traffic from jump server
    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      security_groups = [aws_security_group.sg_jump_server.id]
    }

    # default outbound traffic
    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

  
}