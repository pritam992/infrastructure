
# # Existing S3 bucket lookup

# data "aws_s3_bucket" "existing" {
#   bucket = var.existing_s3_bucket_name
# }

# # CloudFront Module

# module "cloudfront" {
#   source = "../../modules/cloudfront"

#   bucket_id = data.aws_s3_bucket.existing.id

#   bucket_regional_domain_name = data.aws_s3_bucket.existing.bucket_regional_domain_name

#   environment  = var.environment
#   project_name = var.project_name

#   default_root_object = var.cloudfront_default_root_object
#   spa_mode            = var.cloudfront_spa_mode

#   tags = {
#     Environment = var.environment
#     Project     = var.project_name
#     ManagedBy   = "Terraform"
#     Component   = "CloudFront"
#   }
# }
