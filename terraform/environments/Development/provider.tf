provider "aws" {
region = var.aws_region
access_key = ""
secret_key = ""
}

provider "aws" {
alias = "us-east-1"
access_key = ""
secret_key = ""
}