
# AWS Configuration

aws_region  = "ap-south-1"
aws_profile = "default"

# Project Configuration

project_name = "Cloud-Master-Academy-Web-App-dev"
environment  = "dev"

# VPC Configuration

vpc_cidr = "192.172.0.0/24"

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

public_subnet_cidrs = [
  "192.172.0.0/26",
  "192.172.0.64/26"
]

private_subnet_cidrs = [
  "192.172.0.128/26",
  "192.172.0.192/26"
]

# Application Configuration

mysql_port = 3306
app_port   = 8080

app_ingress_cidr_blocks = []

# S3 Configuration

existing_s3_bucket_name = "prjct1-user-upload-ec2-s3-durga-dev"

# Route 53 Configuration

domain_name  = "cloudmasteracademy.in"
record_name  = ""
record_value = ""

# CloudFront Configuration

cloudfront_default_root_object = "index.html"
cloudfront_spa_mode            = false
