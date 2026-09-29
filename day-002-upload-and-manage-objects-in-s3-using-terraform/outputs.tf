output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.storage_bucket.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.storage_bucket.arn
}

output "uploaded_object_keys" {
  description = "List of uploaded S3 object keys"

  value = [
    for object in aws_s3_object.uploaded_files : object.key
  ]
}

output "uploaded_object_urls" {
  description = "S3 object URLs"

  value = {
    for name, object in aws_s3_object.uploaded_files :
    name => "s3://${object.bucket}/${object.key}"
  }
}