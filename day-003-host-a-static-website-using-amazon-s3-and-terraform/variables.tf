variable "aws_region" {
  description = "AWS region where the website bucket will be created"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string

  validation {
    condition = (
      length(var.bucket_name) >= 3 &&
      length(var.bucket_name) <= 63 &&
      can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.bucket_name))
    )

    error_message = "Bucket name must contain 3-63 lowercase letters, numbers, or hyphens, and must start and end with a letter or number."
  }
}

variable "environment" {
  description = "Environment name for resource tagging"
  type        = string
  default     = "development"
}

variable "website_files" {
  description = "Map of local website files to their S3 object keys"

  type = map(string)

  default = {
    "website/index.html" = "index.html"
    "website/error.html" = "error.html"
    "website/style.css"  = "style.css"
  }
}

variable "content_types" {
  description = "Content types for website objects"

  type = map(string)

  default = {
    "index.html" = "text/html"
    "error.html" = "text/html"
    "style.css"  = "text/css"
  }
}