variable "domain_name" {
  description = "Root domain"
  type        = string
}

variable "record_name" {
  description = "Development subdomain"
  type        = string
  default     = "dev"
}

variable "cloudfront_domain_name" {
  description = "CloudFront distribution domain"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "Development"
}