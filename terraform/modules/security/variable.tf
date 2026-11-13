variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "mysql_port" {
  type    = number
  default = 3306
}

variable "app_port" {
  type    = number
  default = 8080
}

variable "app_ingress_cidr_blocks" {
  description = "Approved CIDR blocks allowed to access the application"
  type        = list(string)
  default     = []
}