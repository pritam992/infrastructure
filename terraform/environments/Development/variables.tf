variable "domain_name" {
  type        = string
  description = "Domain name"
}

variable "environment" {
  type    = string
  default = "Development"
}

variable "project_name" {
  type    = string
  default = "Route53-Project"
}