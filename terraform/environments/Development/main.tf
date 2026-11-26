
# S3 Module - Development

module "dev-s3" {
  source = "../../modules/s3"

  s3_name = var.existing_s3_bucket_name
}
