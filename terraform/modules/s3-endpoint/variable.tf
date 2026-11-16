variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_route_table_ids" {
  type = list(string)
}

variable "existing_s3_bucket_name" {
  type = string
}