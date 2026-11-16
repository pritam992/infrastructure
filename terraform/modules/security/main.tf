# Application Security Group
resource "aws_security_group" "app" {
  name        = "${var.project_name}-dev-app-sg"
  description = "Security group for DEV application resources"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.app_ingress_cidr_blocks

    content {
      description = "Approved application traffic"
      from_port   = var.app_port
      to_port     = var.app_port
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-dev-app-sg"
  }
}

# RDS Security Group
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-dev-rds-sg"
  description = "Security group for private MySQL RDS"
  vpc_id      = var.vpc_id

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-dev-rds-sg"
  }
}

# Allow MySQL only from the application Security Group
resource "aws_vpc_security_group_ingress_rule" "mysql_from_app" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.app.id

  description = "Allow MySQL from DEV application"
  ip_protocol = "tcp"
  from_port   = var.mysql_port
  to_port     = var.mysql_port
}