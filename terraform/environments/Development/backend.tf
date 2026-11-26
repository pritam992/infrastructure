
terraform {
  backend "s3" {
    bucket  = "YOUR-EXISTING-STATE-BUCKET"
    key     = "infrastructure/Development/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
