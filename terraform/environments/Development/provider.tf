
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "S3-RDS-Project"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}
