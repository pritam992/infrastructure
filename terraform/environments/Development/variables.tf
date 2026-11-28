
# AWS Configuration

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile"
  type        = string
  default     = "default"
}

# Project Configuration

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

# VPC Configuration

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

# Application Configuration

variable "mysql_port" {
  description = "MySQL port"
  type        = number
}

variable "app_port" {
  description = "Application port"
  type        = number
}

variable "app_ingress_cidr_blocks" {
  description = "Application ingress CIDR blocks"
  type        = list(string)
  default     = []
}

# S3 Configuration

variable "existing_s3_bucket_name" {
  description = "Existing S3 bucket name"
  type        = string
}

# Route 53 Configuration

variable "domain_name" {
  description = "Route 53 domain name"
  type        = string
}

variable "record_name" {
  description = "DNS record name"
  type        = string
  default     = ""
}

variable "record_value" {
  description = "DNS record value"
  type        = string
  default     = ""
}

# CloudFront Configuration

variable "cloudfront_default_root_object" {
  description = "Default website page"
  type        = string
  default     = "index.html"
}

variable "cloudfront_spa_mode" {
  description = "Enable SPA route fallback"
  type        = bool
  default     = false
}
