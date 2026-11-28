
# Route 53 Hosted Zone
resource "aws_route53_zone" "this" {
  name = var.domain_name

  tags = {
    Name        = var.domain_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = var.project_name
  }
}

# A Record - Root Domain
resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

# CNAME Record - WWW Domain
resource "aws_route53_record" "www" {
  count = var.create_www_record ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300

  records = [
    var.cloudfront_domain_name
  ]
}
