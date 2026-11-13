resource "aws_route53_zone" "this" {
  name = var.domain_name

  tags = {
    Name        = "${var.project_name}-hosted-zone"
    Environment = var.environment
  }
}

resource "aws_route53_record" "this" {
  count = var.record_value != "" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id
  name    = "${var.record_name}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [var.record_value]
}