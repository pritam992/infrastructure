module "dev-s3" {
  source = "../../modules/S3"

  bucket_name = "cm-test-module-s3-01"
}