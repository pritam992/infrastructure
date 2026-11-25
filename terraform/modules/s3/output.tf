output "bucket_id" {
  description = "S3 bucket ID"
  value       = aws_s3_bucket.demo.id
}

output "bucket_regional_domain_name" {
  description = "S3 bucket regional domain name"
  value       = aws_s3_bucket.demo.bucket_regional_domain_name
}