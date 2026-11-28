
# ============================================================
# Origin Access Control (OAC)
# ============================================================

resource "aws_cloudfront_origin_access_control" "this" {
  name        = "${var.project_name}-${var.environment}-oac"
  description = "OAC for static website hosting"

  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


# ============================================================
# CloudFront Cache Policy
# ============================================================

resource "aws_cloudfront_cache_policy" "static" {
  name        = "${var.project_name}-${var.environment}-cache"
  comment     = "Cache policy for static website files"

  min_ttl     = 0
  default_ttl = 3600
  max_ttl     = 86400

  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true

    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }
}


# ============================================================
# CloudFront Distribution
# ============================================================

resource "aws_cloudfront_distribution" "this" {
  enabled         = true
  is_ipv6_enabled = true

  comment = "${var.project_name} ${var.environment} static website"

  default_root_object = var.default_root_object

  # S3 Origin
  origin {
    domain_name              = var.bucket_regional_domain_name
    origin_id                = "s3-static-website-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  # Default Cache Behavior
  default_cache_behavior {
    target_origin_id       = "s3-static-website-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id = aws_cloudfront_cache_policy.static.id

    compress = true
  }

  # SPA Error Handling
  dynamic "custom_error_response" {
    for_each = var.spa_mode ? [403, 404] : []

    content {
      error_code         = custom_error_response.value
      response_code      = 200
      response_page_path = "/${var.default_root_object}"
    }
  }

  # Default CloudFront SSL Certificate (No ACM Required)
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  # Geographic Restrictions
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Resource Tags
  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-cloudfront"
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  )
}


# ============================================================
# S3 Bucket Policy - CloudFront Access
# ============================================================

data "aws_iam_policy_document" "cloudfront_s3_access" {
  statement {
    sid    = "AllowCloudFrontReadOnly"
    effect = "Allow"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_id}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.this.arn
      ]
    }
  }
}


# Attach Bucket Policy
resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.cloudfront_s3_access.json
}
