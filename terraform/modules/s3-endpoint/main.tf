data "aws_region" "current" {}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = var.private_route_table_ids

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid       = "AllowAccessToExistingBucket"
        Effect    = "Allow"
        Principal = "*"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]

        Resource = [
          "arn:aws:s3:::${var.existing_s3_bucket_name}",
          "arn:aws:s3:::${var.existing_s3_bucket_name}/*"
        ]
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-dev-s3-endpoint"
  }
}