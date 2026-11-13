module "vpc" {
  source = "../../modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id

  mysql_port = var.mysql_port
  app_port   = var.app_port

  app_ingress_cidr_blocks = var.app_ingress_cidr_blocks
}

module "s3_endpoint" {
  source = "../../modules/s3-endpoint"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id

  private_route_table_ids = module.vpc.private_route_table_ids

  existing_s3_bucket_name = var.existing_s3_bucket_name
}

module "rds_networking" {
  source = "../../modules/rds-networking"

  project_name       = var.project_name
  private_subnet_ids = module.vpc.private_subnet_ids
}

# module "route53" {
#   source = "../../modules/route53"

#   project_name = var.project_name
#   domain_name  = var.domain_name
#   record_name  = var.record_name
#   record_value = var.record_value
# }