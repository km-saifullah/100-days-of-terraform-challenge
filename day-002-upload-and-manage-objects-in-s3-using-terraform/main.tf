terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Create S3 Bucket
resource "aws_s3_bucket" "storage_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Project     = "100-days-aws-terraform"
    Day         = "02"
    ManagedBy   = "Terraform"
  }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "storage_bucket" {
  bucket = aws_s3_bucket.storage_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "storage_bucket" {
  bucket = aws_s3_bucket.storage_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Upload Multiple Files to S3
resource "aws_s3_object" "uploaded_files" {
  for_each = var.upload_files

  bucket = aws_s3_bucket.storage_bucket.id

  key    = each.value
  source = "${path.module}/${each.key}"

  etag = filemd5("${path.module}/${each.key}")

  content_type = lookup(
    var.content_types,
    each.value,
    "application/octet-stream"
  )

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  depends_on = [
    aws_s3_bucket_public_access_block.storage_bucket,
    aws_s3_bucket_server_side_encryption_configuration.storage_bucket
  ]
}