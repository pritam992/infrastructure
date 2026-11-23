variable "env" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
}

variable "s3_prefix" {
  type        = string
  description = "Base name prefix for client file storage bucket"
  default     = "prjct1-user-upload-ec2-s3"
}
