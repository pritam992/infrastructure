resource "aws_s3_bucket" "demo" {
  bucket = var.bucket_name

  tags = var.default_tag
}

resource "aws_s3_bucket_versioning" "demo" {
   bucket = aws_s3_bucket.demo.id
  versioning_configuration {
    status = var.bucket_version
  }
}