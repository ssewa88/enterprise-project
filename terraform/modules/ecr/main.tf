resource "aws_ecr_repository" "app" {
  name = "${var.env}-hello-app"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true

  tags = {
    Name        = "${var.env}-hello-app"
    Project     = "enterprise-project"
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}
