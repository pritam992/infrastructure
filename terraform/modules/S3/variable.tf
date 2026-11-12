variable "bucket_name" {
  type = string
  description = "define the s3 bucket name"
  default = "cm-test-module-s3-01"
}

variable "default_tag" {
  type = map(string)
  description = "default tags for the resource"
  default = {
    Name        = "My bucket"
    Environment = "Dev"
    iac         = "terraform"
  }
}

variable "bucket_version" {
  type = string
  default = "Enabled"
}