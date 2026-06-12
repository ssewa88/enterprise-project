terraform {
  backend "s3" {
    bucket         = "gabriel-enterprise-project-terraform-state"
    key            = "staging/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "enterprise-project-terraform-locks"
    encrypt        = true
  }
}

