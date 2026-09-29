variable "aws_region" {
  description = "AWS region where the S3 bucket will be created"
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

variable "upload_files" {
  description = "Map of local file paths to their S3 object keys"

  type = map(string)

  default = {
    "files/documents/welcome.txt"       = "documents/welcome.txt"
    "files/documents/company-info.txt"  = "documents/company-info.txt"
    "files/configuration/app-config.json" = "configuration/app-config.json"
    "files/images/logo.svg"             = "images/logo.svg"
  }
}

variable "content_types" {
  description = "Content types associated with uploaded S3 objects"

  type = map(string)

  default = {
    "documents/welcome.txt"        = "text/plain"
    "documents/company-info.txt"   = "text/plain"
    "configuration/app-config.json" = "application/json"
    "images/logo.svg"              = "image/svg+xml"
  }
}