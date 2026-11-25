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


# ------------------------------------------------------------
# CloudFront Cache Policy
# ------------------------------------------------------------
# CloudFront caches static files at edge locations.

resource "aws_cloudfront_cache_policy" "static" {
  name        = "${var.project_name}-${var.environment}-cache"
  comment     = "Cache policy for static website files"

  min_ttl     = 0
  default_ttl = 3600
  max_ttl     = 86400

  parameters_in_cache_key_and_forwarded_to_origin {

    # Compress files before delivering them to users.
    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true

    # Static files usually do not need cookies.
    cookies_config {
      cookie_behavior = "none"
    }

    # Do not forward unnecessary headers to S3.
    headers_config {
      header_behavior = "none"
    }

    # Do not include query strings in the cache key.
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}


# ------------------------------------------------------------
# CloudFront Distribution
# ------------------------------------------------------------
# This is the main resource that delivers website content.

resource "aws_cloudfront_distribution" "this" {

  # Enable the distribution.
  enabled = true

  # Description visible in the AWS console.
  comment = "${var.project_name} ${var.environment} static website"

  # Serve index.html when users open the root domain.
  default_root_object = var.default_root_object

  # Enable IPv6 support.
  is_ipv6_enabled = true


  # ----------------------------------------------------------
  # S3 Origin
  # ----------------------------------------------------------
 
  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = "s3-static-website-origin"

    # Attach the OAC created above.
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }


  # ----------------------------------------------------------
  # Default Cache Behavior
  # ----------------------------------------------------------
 
  default_cache_behavior {
    target_origin_id       = "s3-static-website-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    # Attach the cache policy created above.
    cache_policy_id = aws_cloudfront_cache_policy.static.id

    # Enable automatic compression for supported content.
    compress = true
  }


  # ----------------------------------------------------------
  # SPA Error Handling
  # ----------------------------------------------------------
  
  dynamic "custom_error_response" {
    for_each = var.spa_mode ? [403, 404] : []

    content {
      error_code         = custom_error_response.value
      response_code      = 200
      response_page_path = "/${var.default_root_object}"
    }
  }


  # ----------------------------------------------------------
  # Viewer Certificate
  # ----------------------------------------------------------
  
  viewer_certificate {
    cloudfront_default_certificate = true
  }


  # ----------------------------------------------------------
  # Geographic Restrictions
  # ----------------------------------------------------------
  
    restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }


  # ----------------------------------------------------------
  # Resource Tags
  # ----------------------------------------------------------

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


# ------------------------------------------------------------
#  S3 Bucket Policy
# ------------------------------------------------------------
# CloudFront needs permission to read files from S3.

data "aws_iam_policy_document" "cloudfront_s3_access" {

  statement {
    sid    = "AllowCloudFrontReadOnly"
    effect = "Allow"

    # CloudFront only needs permission to read website files.
    actions = [
      "s3:GetObject"
    ]

    # Allow access to objects inside the existing bucket.
    resources = [
      "arn:aws:s3:::${var.bucket_id}/*"
    ]

    # CloudFront is the AWS service accessing the bucket.
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    # Restrict access to this specific CloudFront distribution.
    # Other CloudFront distributions cannot use this permission.

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.this.arn
      ]
    }
  }
}


# Attach the policy to the existing S3 bucket.

resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.cloudfront_s3_access.json
}