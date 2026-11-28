output "bucket_id" {
  value = aws_s3_bucket.demo.id
}

output "bucket_arn" {
  value = aws_s3_bucket.demo.arn
}

output "bucket_name" {
  value = aws_s3_bucket.demo.bucket
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.demo.bucket_regional_domain_name
}

output "bucket_website_endpoint" {
  value = aws_s3_bucket_website_configuration.demo_website.website_endpoint
}