# Create security group for Jump Server (no inbound trafic)
resource "aws_security_group" "sg_jump_server" {
    name        = "${local.name_prefix}-sg_jump_server"
    description = "Secutity group for Jump Server"
    vpc_id      = var.vpc_id

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
    description = "Secutity group for ALB"
    vpc_id      = var.vpc_id


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
    
    # Allow SSH traffic from Internet
    ingress  {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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
    description = "Secutity group for ECS"
    vpc_id      = var.vpc_id


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
      security_groups = [aws_security_group.sg_alb.id]
    }

}

# Create Security Group for RDS
resource "aws_security_group" "sg_rds" {
    name        = "${local.name_prefix}-sg_rds"
    description = "Secutity group for RDS"
    vpc_id      = var.vpc_id


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