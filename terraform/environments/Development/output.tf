
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

# output "rds_subnet_group_name" {
#   description = "Private RDS DB subnet group name"
#   value       = module.rds_networking.rds_subnet_group_name
# }

output "s3_bucket_id" {
  value = module.dev-s3.bucket_id
}

output "s3_bucket_arn" {
  value = module.dev-s3.bucket_arn
}

output "s3_bucket_name" {
  value = module.dev-s3.bucket_name
}
