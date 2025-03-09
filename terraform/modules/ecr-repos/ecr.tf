module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  for_each = toset(var.repository_names)

  repository_name = "${var.app_name}-${var.env}-${each.value}"

  repository_read_write_access_arns = ["${data.aws_caller_identity.current.arn}"]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = "${var.app_name}-${var.env}-ecr-repo"
  }
}