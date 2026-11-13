variable "project_name" {
  type = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the RDS DB subnet group"
  type        = list(string)
}