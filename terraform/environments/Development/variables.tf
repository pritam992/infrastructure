variable "aws_region" {
  description = "AWS region for DEV environment"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile used for DEV deployment"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_cidr" {
  description = "DEV VPC CIDR"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for DEV"
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

variable "mysql_port" {
  description = "MySQL database port"
  type        = number
  default     = 3306
}

variable "app_port" {
  description = "Application listening port"
  type        = number
  default     = 8080
}

variable "app_ingress_cidr_blocks" {
  description = "Approved CIDR ranges allowed to access the application"
  type        = list(string)
  default     = []
}

variable "existing_s3_bucket_name" {
  description = "Name of the existing S3 bucket"
  type        = string
}

variable "domain_name" {
  type        = string
  description = "Registered domain name"
}

variable "record_name" {
  type    = string
  default = "www"
}

variable "record_value" {
  type    = string
  default = ""
}