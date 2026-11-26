
# We use this to attach a policy that allows CloudFront access.
variable "bucket_id" {
  description = "Name of the existing S3 bucket"
  type        = string
}

# S3 regional REST endpoint.
# CloudFront uses this endpoint to retrieve website files.
variable "bucket_regional_domain_name" {
  description = "Regional S3 endpoint for the CloudFront origin"
  type        = string
}

# Environment name, for example Development or Production.
# This is used in resource names and tags.
variable "environment" {
  description = "Environment where CloudFront is deployed"
  type        = string
}

# Project name used for resource naming and identification.
variable "project_name" {
  description = "Name of the project"
  type        = string
}

# Default page displayed when a user opens the website.
variable "default_root_object" {
  description = "Default website page"
  type        = string
  default     = "index.html"
}

# Enable this only when hosting a single-page application
# that needs index.html returned for missing routes.
variable "spa_mode" {
  description = "Enable index.html fallback for SPA routes"
  type        = bool
  default     = false
}

# Additional resource tags.
# The calling environment can provide its own tags.
variable "tags" {
  description = "Tags for CloudFront resources"
  type        = map(string)
  default     = {}
}