
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "aws_profile" {
  description = "AWS CLI profile"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "existing_s3_bucket_name" {
  description = "Existing S3 bucket name"
  type        = string
}

variable "cloudfront_default_root_object" {
  description = "Default website page"
  type        = string
  default     = "index.html"
}

variable "cloudfront_spa_mode" {
  description = "Enable SPA mode"
  type        = bool
  default     = false
}
