output "zone_id" {
  value = aws_route53_zone.this.zone_id
}

output "name_servers" {
  value = aws_route53_zone.this.name_servers
}

output "root_record" {
  value = aws_route53_record.root.name
}

output "www_record" {
  value = var.create_www_record ? aws_route53_record.www[0].name : null
}