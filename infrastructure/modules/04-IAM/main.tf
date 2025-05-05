 # IAM ROLE TO ALLOW S3 PUT AND GET ACCESS TO S3 FOR LOGGING
resource "aws_iam_role" "s3_logging_access_role" {
  name = local.s3_logging_access_name
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "s3_logging_policy" {
  name = local.s3_logging_access_policy_name
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_logging_policy_attachment" {
  role       = aws_iam_role.s3_logging_access_role.name
  policy_arn = aws_iam_policy.s3_logging_policy.arn
  
}


# Create ECS Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name               = "${local.name_prefix}-ecs-execution-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy_attachment" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  
}

# Create ECS Task Role
resource "aws_iam_role" "ecs_task_role" {
  name               = "${local.name_prefix}-ecs-task-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.s3_logging_policy.arn
  
}

# Create ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
    name               = "${local.name_prefix}-ecs-task-execution-role"

    assume_role_policy = jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }]
    })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  
}

# Create an Instance Profile with SSM Permissions for Jump Server
resource "aws_iam_role" "ssm_instance_role" {
    name               = "${local.name_prefix}-jumpserver-ssm-instance-role"

    assume_role_policy = jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }]
    })

}

resource "aws_iam_role_policy_attachment" "ssm_core_policy" {
  role       = aws_iam_role.ssm_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

  
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${local.name_prefix}-jumpsever-ssm-instance-profile"
  role = aws_iam_role.ssm_instance_role.name
  
}