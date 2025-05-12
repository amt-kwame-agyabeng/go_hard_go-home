# Create a data source for IAM Policy Document
data "aws_iam_policy_document" "ssm_policy" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["ec2.amazonaws.com"]
            
        }
        
    }
}