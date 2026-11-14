output "alb_id" {
  description = "ALB ID"
  value       = aws_lb.this.id
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "ALB Route53 zone ID"
  value       = aws_lb.this.zone_id
}

output "target_group_arn" {
  description = "Target group ARN"
  value       = aws_lb_target_group.this.arn
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = aws_security_group.alb.id
}