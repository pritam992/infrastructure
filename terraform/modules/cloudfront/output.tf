# ============================================================
# CloudFront Module - Outputs
# ============================================================

# Distribution ID is useful for invalidations and AWS CLI operations.
output "distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.this.id
}

# Domain name used to access the website.
output "distribution_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.this.domain_name
}

# ARN of the CloudFront distribution.
output "distribution_arn" {
  description = "CloudFront distribution ARN"
  value       = aws_cloudfront_distribution.this.arn
}

# CloudFront hosted zone ID is useful for Route 53 aliases.
output "distribution_hosted_zone_id" {
  description = "CloudFront hosted zone ID"
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}