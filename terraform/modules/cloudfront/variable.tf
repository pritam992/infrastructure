
# ============================================================
# S3 Bucket Configuration
# ============================================================

variable "bucket_id" {
  description = "Name of the existing S3 bucket"
  type        = string
}

variable "bucket_regional_domain_name" {
  description = "Regional S3 endpoint for the CloudFront origin"
  type        = string
}


# ============================================================
# Project Configuration
# ============================================================

variable "environment" {
  description = "Environment where CloudFront is deployed"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}


# ============================================================
# CloudFront Configuration
# ============================================================

variable "default_root_object" {
  description = "Default website page"
  type        = string
  default     = "index.html"
}

variable "spa_mode" {
  description = "Enable index.html fallback for SPA routes"
  type        = bool
  default     = false
}


# ============================================================
# Resource Tags
# ============================================================

variable "tags" {
  description = "Tags for CloudFront resources"
  type        = map(string)
  default     = {}
}
