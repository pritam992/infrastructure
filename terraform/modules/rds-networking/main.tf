resource "aws_db_subnet_group" "this" {
  name        = "${lower(var.project_name)}-dev-rds-subnet-group"
  description = "Private subnet group for DEV RDS"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${lower(var.project_name)}-dev-rds-subnet-group"
    Environment = "dev"
  }
}