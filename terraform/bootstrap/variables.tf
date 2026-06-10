variable "aws_region" {
  description = "AWS region where bootstrap resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform remote state"
  type        = string
  default     = "gabriel-enterprise-project-terraform-state"
}

variable "lock_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
  default     = "enterprise-project-terraform-locks"
}