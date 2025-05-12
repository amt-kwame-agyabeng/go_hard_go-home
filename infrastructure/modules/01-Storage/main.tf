# S3 bucket module
resource "aws_s3_bucket" "logging_bucket" {
    bucket = var.bucket_name  
}

# Enable bucket versioning on log bucket
resource "aws_s3_bucket_versioning" "logging_bucket" {
  bucket = aws_s3_bucket.logging_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable block public access
resource "aws_s3_bucket_public_access_block" "logging_bucket" {
  bucket                  = aws_s3_bucket.logging_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
} 

# Enable Access logging
resource "aws_s3_bucket_logging" "logging_bucket" {
  bucket = aws_s3_bucket.logging_bucket.id
  target_bucket = aws_s3_bucket.logging_bucket.id
  target_prefix = "log/"

}

# Enable server side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "logging_bucket" {
  bucket = aws_s3_bucket.logging_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
  
}

