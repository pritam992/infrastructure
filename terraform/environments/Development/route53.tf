module "route53" {
  source = "../../modules/route53"

  domain_name = var.domain_name

  environment  = var.environment
  project_name = var.project_name
}