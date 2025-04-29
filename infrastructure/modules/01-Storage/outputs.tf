# S3 bucket
output "bucket_name" {
    value = aws_s3_bucket.secure_storage.id

}