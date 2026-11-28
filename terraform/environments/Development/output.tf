
# VPC Outputs

# output "vpc_id" {
#   description = "DEV VPC ID"
#   value       = module.vpc.vpc_id
# }

# output "vpc_cidr" {
#   description = "DEV VPC CIDR"
#   value       = module.vpc.vpc_cidr
# }

# output "public_subnet_ids" {
#   description = "Public subnet IDs"
#   value       = module.vpc.public_subnet_ids
# }

# output "private_subnet_ids" {
#   description = "Private subnet IDs"
#   value       = module.vpc.private_subnet_ids
# }

# output "nat_gateway_id" {
#   description = "NAT Gateway ID"
#   value       = module.vpc.nat_gateway_id
# }

# Security Outputs

# output "app_security_group_id" {
#   description = "Application security group ID"
#   value       = module.security.app_security_group_id
# }

# output "rds_security_group_id" {
#   description = "RDS security group ID"
#   value       = module.security.rds_security_group_id
# }

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

# output "cloudfront_distribution_id" {
#   description = "CloudFront distribution ID"
#   value       = module.cloudfront.distribution_id
# }

# output "cloudfront_distribution_domain_name" {
#   description = "CloudFront domain name"
#   value       = module.cloudfront.distribution_domain_name
# }

# output "cloudfront_website_url" {
#   description = "HTTPS URL for the static website"
#   value       = "https://${module.cloudfront.distribution_domain_name}"
# }

# output "cloudfront_distribution_arn" {
#   description = "CloudFront distribution ARN"
#   value       = module.cloudfront.distribution_arn
# }

# RDS Outputs

# output "rds_subnet_group_name" {
#   description = "Private RDS DB subnet group name"
#   value       = module.rds_networking.rds_subnet_group_name
# }

# S3 Outputs

output "s3_bucket_id" {
  value = module.dev-s3.bucket_id
}

output "s3_bucket_arn" {
  value = module.dev-s3.bucket_arn
}

output "s3_bucket_name" {
  value = module.dev-s3.bucket_name
}
