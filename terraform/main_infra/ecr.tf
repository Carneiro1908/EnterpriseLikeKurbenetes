# NOTE: use force delete
resource "aws_ecr_repository" "app_repository" {
    name = "app-container-repository"
    image_tag_mutability = "MUTABLE"

    force_delete = true  

    image_scanning_configuration {
      scan_on_push = true
    }
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle" {
    repository = aws_ecr_repository.app_repository.name  

    policy = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "description": "Mantain only last 10 images",
                "selection": {
                    "tagStatus": "any",
                    "countType": "imageCountMoreThan",
                    "countNumber": 10
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}