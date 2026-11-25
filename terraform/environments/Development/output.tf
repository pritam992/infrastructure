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

# output "app_security_group_id" {
#   description = "Application security group ID"
#   value       = module.security.app_security_group_id
# }

# output "rds_security_group_id" {
#   description = "RDS security group ID"
#   value       = module.security.rds_security_group_id
# }

# # output "s3_endpoint_id" {
# #   description = "S3 Gateway endpoint ID"
# #   value       = module.s3_endpoint.s3_endpoint_id
# # }

# output "rds_subnet_group_name" {
#   description = "Private RDS DB subnet group name"
#   value       = module.rds_networking.rds_subnet_group_name
# }

# ============================================================
# CloudFront - Development Outputs
# ============================================================

# CloudFront distribution ID.
output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.cloudfront.distribution_id
}

# CloudFront domain name.
output "cloudfront_distribution_domain_name" {
  description = "CloudFront domain name"
  value       = module.cloudfront.distribution_domain_name
}

# Website URL.
output "cloudfront_website_url" {
  description = "HTTPS URL for the static website"
  value       = "https://${module.cloudfront.distribution_domain_name}"
}

# CloudFront distribution ARN.
output "cloudfront_distribution_arn" {
  description = "CloudFront distribution ARN"
  value       = module.cloudfront.distribution_arn
}