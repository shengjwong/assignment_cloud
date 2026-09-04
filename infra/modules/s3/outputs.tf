output "bucket_id" {
  value = data.aws_s3_bucket.uploads.id
}

output "bucket_arn" {
  value = data.aws_s3_bucket.uploads.arn
}

output "bucket_regional_domain_name" {
  value = data.aws_s3_bucket.uploads.bucket_regional_domain_name
}

