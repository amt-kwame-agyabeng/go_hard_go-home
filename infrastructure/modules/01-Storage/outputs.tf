# S3 bucket
output "bucket_name" {
    value = aws_s3_bucket.logging_bucket.id

}
output "bucket_arn" {
    value = aws_s3_bucket.logging_bucket.arn
}