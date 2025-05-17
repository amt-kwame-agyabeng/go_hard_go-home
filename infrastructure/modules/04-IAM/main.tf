# Create an Instance Profile with SSM Permissions for Jump Server
resource "aws_iam_role" "ssm_role" {
  name = local.ssm_role_name
  assume_role_policy = data.aws_iam_policy_document.ssm_policy.json
  
}

#Attach Policy to SSM Role
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  for_each   = toset(var.ssm_policy_arns)
  role       = aws_iam_role.ssm_role.name
  policy_arn = each.value
}

# Create SSM Instance Profile
resource "aws_iam_instance_profile" "e2_instance_profile" {
  name = local.ssm_profile_name
  role = aws_iam_role.ssm_role.name
}


#  Create ECS Task Role
resource "aws_iam_role" "ecs_task_role" {
  name = local.ecs_task_role_name
  assume_role_policy = file("${path.root}/policies/ecs-assume-role-policy.json")
}

# Attach Permission Policies to ECS Task Role
resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  for_each   = toset(var.ecs_task_policy_arns)
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = each.value

}

# Create ECS Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name = local.ecs_execution_role_name
  assume_role_policy = file("${path.root}/policies/ecs-assume-role-policy.json")
  
}

# Attach Permission Policies to ECS Execution Role
resource "aws_iam_role_policy_attachment" "ecs_execution_policy_attachment" {
  for_each   = toset(var.ecs_execution_policy_arns)
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = each.value
}

# Create ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = local.ecs_task_execution_role_name
  assume_role_policy = file("${path.root}/policies/ecs-assume-role-policy.json")
}

# Attach Permission Policies to ECS Task Execution Role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  for_each   = toset(var.ecs_task_policy_arns)
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = each.value
}

# IAM ROLE TO ALLOW S3 PUT AND GET ACCESS TO S3 FOR LOGGING
resource "aws_iam_role" "s3_role" {
  name = local.s3_role_name
  assume_role_policy = file("${path.root}/policies/s3-assume-role-policy.json")

  
}

# Attach Permission Policies to S3 Role
resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  for_each   = toset(var.s3_policy_arns)
  role       = aws_iam_role.s3_role.name
  policy_arn = each.value
}