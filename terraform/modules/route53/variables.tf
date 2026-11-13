variable "domain_name" {
  description = "Your registered domain name"
  type        = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "record_name" {
  description = "DNS record name, such as www"
  type        = string
  default     = "www"
}

variable "record_value" {
  description = "Public IPv4 address for the A record; leave empty until available"
  type        = string
  default     = ""
}