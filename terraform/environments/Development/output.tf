
# Route 53 Outputs

output "route53_hosted_zone_id" {
  description = "Route 53 Hosted Zone ID"
  value       = module.route53.hosted_zone_id
}

output "route53_name_servers" {
  description = "Route 53 Name Servers"
  value       = module.route53.name_servers
}

# CloudFront Outputs

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
