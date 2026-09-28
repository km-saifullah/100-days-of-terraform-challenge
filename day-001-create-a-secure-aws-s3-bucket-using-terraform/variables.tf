
variable "aws_region" {
  description = "AWS region where the S3 bucket will be created"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket"
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