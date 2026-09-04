# assignment-s3-uploads: existing application bucket.
# The bucket itself is not managed by Terraform because the Academy
# account's SCP denies s3:GetBucketObjectLockConfiguration during refresh.
# Terraform still manages the bucket's public-access, policy and CORS settings.

data "aws_s3_bucket" "uploads" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "uploads" {
  bucket = data.aws_s3_bucket.uploads.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = data.aws_s3_bucket.uploads.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid       = "PublicReadEventImages"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${data.aws_s3_bucket.uploads.arn}/${var.public_read_prefix}"
      }
    ]
  })

  depends_on = [
    aws_s3_bucket_public_access_block.uploads
  ]
}

resource "aws_s3_bucket_cors_configuration" "uploads" {
  bucket = data.aws_s3_bucket.uploads.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}

