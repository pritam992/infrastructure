
output "s3_bucket_name" {
  value = module.s3.bucket_id
}


output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "rds_database_name" {
  value = var.database_name
}

output "rds_identifier" {
  value = module.rds.db_identifier
}
