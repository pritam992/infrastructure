output "ec2_instance_ids" {
  description = "Created EC2 instance IDs"
  value       = module.ec2.instance_ids
}

output "ec2_private_ips" {
  description = "Created EC2 private IPs"
  value       = module.ec2.instance_private_ips
}

output "ec2_security_group_id" {
  description = "EC2 security group ID"
  value       = module.ec2.security_group_id
}

output "alb_id" {
  description = "Application Load Balancer ID"
  value       = module.alb.alb_id
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS"
  value       = module.alb.alb_dns_name
}

output "alb_url" {
  description = "Application URL"
  value       = "http://${module.alb.alb_dns_name}"
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = module.alb.target_group_arn
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = module.alb.alb_security_group_id
}