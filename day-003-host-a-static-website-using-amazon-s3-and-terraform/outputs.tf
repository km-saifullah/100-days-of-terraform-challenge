output "s3_bucket_name" {
  description = "Name of the website bucket"
  value       = aws_s3_bucket.website_bucket.id
}

output "s3_bucket_arn" {
  description = "ARN of the website bucket"
  value       = aws_s3_bucket.website_bucket.arn
}

output "website_endpoint" {
  description = "S3 static website endpoint"

  value = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}

output "website_files" {
  description = "Uploaded website object keys"

  value = [
    for object in aws_s3_object.website_files : object.key
  ]
}

output "website_hosting_status" {
  description = "Static website hosting configuration"

  value = {
    index_document = "index.html"
    error_document = "error.html"
    public_read    = true
  }
}