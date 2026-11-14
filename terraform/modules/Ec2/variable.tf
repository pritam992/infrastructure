# variable "ami-id" {
#   type = string
#   default = "ami-0f19324397f53458f"
# }

# variable "instance-type" {
#   type = string
#   default = "t3.micro"
  

  variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Existing subnet IDs"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed for SSH"
  type        = string
}

variable "security_group_id" {
  description = "sg id"
  type = string
}