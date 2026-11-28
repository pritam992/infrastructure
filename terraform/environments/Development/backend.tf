
terraform {
  backend "s3" {
    bucket  = "infrastructure-project-dev"
    key     = "infrastructure/Development/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
