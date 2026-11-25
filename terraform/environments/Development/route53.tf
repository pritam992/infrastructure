module "route53" {
  source = "../../modules/route53"

  domain_name            = var.domain_name
  record_name            = var.record_name
  cloudfront_domain_name = var.cloudfront_domain_name

  environment  = var.environment
  project_name = var.project_name
}