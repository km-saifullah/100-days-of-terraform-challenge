
output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.secure_bucket.id
}

output "s3_bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.secure_bucket.arn
}

output "s3_bucket_region" {
  description = "AWS region of the S3 bucket"
  value       = var.aws_region
}

output "s3_bucket_security_status" {
  description = "Security configuration of the bucket"

  value = {
    public_access_blocked = true
    encryption_enabled    = true
    encryption_algorithm  = "AES256"
  }
}