# ALB Security Group

resource "aws_security_group" "alb" {
  name        = "${var.environment}-alb-sg"
  description = "Security group for ${var.environment} ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from internet"
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
    Name        = "${var.environment}-alb-sg"
    Environment = var.environment
  }
}


# Application Load Balancer

resource "aws_lb" "this" {
  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = var.subnet_ids

  tags = {
    Name        = "${var.environment}-alb"
    Environment = var.environment
  }
}


# Target Group

resource "aws_lb_target_group" "this" {
  name = "${var.environment}-tg"

  port     = 80
  protocol = "HTTP"

  vpc_id = var.vpc_id

  target_type = "instance"

  health_check {
    enabled = true

    protocol = "HTTP"

    port = "80"

    path = "/"

    healthy_threshold = 2

    unhealthy_threshold = 2

    timeout = 5

    interval = 30

    matcher = "200"
  }

  tags = {
    Name        = "${var.environment}-target-group"
    Environment = var.environment
  }
}


# Register EC2 instances with Target Group

resource "aws_lb_target_group_attachment" "this" {
  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.this.arn

  target_id = var.instance_ids[count.index]

  port = 80
}


# ALB Listener

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn

  port = 80

  protocol = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn
  }
}