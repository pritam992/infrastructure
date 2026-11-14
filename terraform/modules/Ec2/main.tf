# =========================
# Latest Amazon Linux 2023 AMI
# =========================

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}


# =========================
# EC2 Security Group
# =========================

resource "aws_security_group" "ec2" {
  name        = "${var.environment}-ec2-sg"
  description = "Security group for ${var.environment} EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-ec2-sg"
    Environment = var.environment
  }
}


# =========================
# EC2 Instances
# =========================

resource "aws_instance" "this" {
  count = var.instance_count

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = var.subnet_ids[count.index % length(var.subnet_ids)]

  vpc_security_group_ids = [aws_security_group.ec2.id]

  user_data = <<-EOF
              #!/bin/bash

              dnf update -y
              dnf install -y httpd

              systemctl enable httpd
              systemctl start httpd

              echo "<html>
              <body>
              <h1>Dev Environment</h1>
              <h2>EC2 Instance ${count.index + 1}</h2>
              <p>Terraform Module Project</p>
              </body>
              </html>" > /var/www/html/index.html
              EOF

  tags = {
    Name        = "${var.environment}-ec2-${count.index + 1}"
    Environment = var.environment
  }
}