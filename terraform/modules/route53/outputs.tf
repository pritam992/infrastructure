output "hosted_zone_id" {
  value = aws_route53_zone.this.zone_id
}

output "name_servers" {
  value = aws_route53_zone.this.name_servers
}

output "record_fqdn" {
  value = var.record_value != "" ? aws_route53_record.this[0].fqdn : null
}