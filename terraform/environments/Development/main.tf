# =========================
# EC2 MODULE
# =========================

module "ec2" {
  source = "../../modules/ec2"

  environment = var.environment
  vpc_id      = var.vpc_id
  subnet_ids  = var.subnet_ids

  instance_type  = var.instance_type
  instance_count = var.instance_count
  key_name       = var.key_name

  security_group_id = var.ec2_security_group_id

  allowed_ssh_cidr = var.allowed_ssh_cidr
}

# =========================
# ALB MODULE
# =========================

module "alb" {
  source = "../../modules/alb"

  environment = var.environment
  vpc_id      = var.vpc_id
  subnet_ids  = var.subnet_ids

  security_group_id = var.alb_security_group_id

  instance_ids = module.ec2.instance_ids
}