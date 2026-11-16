
module "s3" {
  source = "../../modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment
}

module "rds" {
  source = "../../modules/rds"

  db_name        = var.db_name
  database_name  = var.database_name
  db_username    = var.db_username
  db_password    = var.db_password

  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids

  environment = var.environment

  multi_az                = var.multi_az
  backup_retention_period = var.backup_retention_period
  deletion_protection    = var.deletion_protection
  skip_final_snapshot    = var.skip_final_snapshot
}
