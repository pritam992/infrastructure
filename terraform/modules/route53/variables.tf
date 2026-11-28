
variable "domain_name" {
  description = "Domain name for Route 53 hosted zone"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  type        = string
}

variable "create_www_record" {
  description = "Create www CNAME record"
  type        = bool
  default     = true
}
