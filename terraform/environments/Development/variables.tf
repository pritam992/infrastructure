variable "aws_region" {
  description = "AWS region"
  type        = string
}

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
  description = "Existing EC2 key pair"
  type        = string
}

variable "ec2_security_group_id" {
  description = "Existing EC2 security group ID"
  type        = string
}

variable "alb_security_group_id" {
  description = "Existing ALB security group ID"
  type        = string
}

variable "security_group_id" {
  description = "Existing EC2 security group ID"
  type        = string
}