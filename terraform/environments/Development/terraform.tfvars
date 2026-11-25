#S3 variables
aws_region  = "ap-south-1"
aws_profile = "default"

project_name = "Cloud-Master-Academy-Web-App-dev"
environment  = "dev"

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

mysql_port = 3306
app_port   = 8080

# Keep empty until the approved application entry point is confirmed.
app_ingress_cidr_blocks = []

# Replace with your team's existing bucket name.
existing_s3_bucket_name = "mprjct1-user-upload-ec2-s3-durga-dev" // it's needed to be replaced with my team's existing bucket name.

# Replace with my team's existing domain name and record name here.
domain_name  = ""
record_name  = ""
record_value = ""

# ============================================================
# CloudFront - Development Configuration
# ============================================================

# Main page served when users access the website.
cloudfront_default_root_object = "index.html"

# Traditional static website: false
cloudfront_spa_mode = false
