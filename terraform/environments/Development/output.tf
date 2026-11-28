# ============================================================
# CloudFront Outputs
# ============================================================

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.cloudfront.distribution_id
}

output "cloudfront_distribution_domain_name" {
  description = "CloudFront domain name"
  value       = module.cloudfront.distribution_domain_name
}

output "cloudfront_website_url" {
  description = "HTTPS URL for the static website"
  value       = "https://${module.cloudfront.distribution_domain_name}"
}

output "cloudfront_distribution_arn" {
  description = "CloudFront distribution ARN"
  value       = module.cloudfront.distribution_arn
}