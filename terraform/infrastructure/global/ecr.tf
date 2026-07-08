resource "aws_ecr_repository" "app_repo" {
    name = "enterprise-like-kubernetes/app"
    image_tag_mutability = "IMMUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }

    encryption_configuration {
      encryption_type = "KMS"
      kms_key = aws_kms_key.ecr_key.arn
    }
}

resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Mantain only 10 last images with tag"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = 10
        }
        action = { type = "expire" }
      },
      {
        rulePriority = 2
        description  = "Delete images without tag in 7 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = { type = "expire" }
      }
    ]
  })
}