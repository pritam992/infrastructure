output "instance_ids" {
  description = "EC2 instance IDs"
  value       = aws_instance.this[*].id
}

output "instance_private_ips" {
  description = "EC2 private IP addresses"
  value       = aws_instance.this[*].private_ip
}

output "security_group_id" {
  description = "EC2 security group ID"
  value       = aws_security_group.ec2.id
}