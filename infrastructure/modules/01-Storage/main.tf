# S3 bucket
resource "aws_s3_bucket" "secure_storage" {
    bucket = var.bucket_name  
}

# S3 bucket versioning and encryption
resource "aws_s3_bucket_public_access_block" "secure_storage" {
    bucket = aws_s3_bucket.secure_storage.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
  
}

# S3 bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_storage" {
  bucket = aws_s3_bucket.secure_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
  
}