# ============================================================
# CloudFront Module - Development Environment
# ============================================================
# This file calls the reusable CloudFront module.
#
# The S3 bucket is created in the existing s3.tf file.
# We pass its name and regional domain name to the module.
#
# Replace "static_site" with your actual S3 resource name
# if it is different in s3.tf.
# ============================================================

# Look up the existing S3 bucket. This does not create a bucket.
module "cloudfront" {
  source = "../../modules/cloudfront"

  # Use the S3 bucket created by the dev-s3 module.
  bucket_id = module.dev-s3.bucket_id

  bucket_regional_domain_name = (
    module.dev-s3.bucket_regional_domain_name
  )

  # Environment and project details.
  environment  = var.environment
  project_name = var.project_name

  # Website configuration.
  default_root_object = var.cloudfront_default_root_object
  spa_mode            = var.cloudfront_spa_mode

  # Additional tags for the CloudFront resources.
  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Component   = "CloudFront"
  }
}