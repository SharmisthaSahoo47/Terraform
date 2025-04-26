variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Environment name like dev/stage/prod"
  type        = string
  default     = "dev"
}
