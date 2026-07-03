resource "aws_iam_role" "bootstrap_role" {
    name = "terraform-bootstrap-role"
    assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json

}

# attaching policies  

# S3 policy

resource "aws_iam_policy" "s3_policy" {
    name = "terraform-bootstrap-s3-policy"
    description = "Policy to allow access to S3 bucket for bootstrap"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    # permissions with bucket
                    "s3:CreateBucket",
                    "s3:DeleteBucket",

                    # permissions with bucket content
                    "s3:GetObject",
                    "s3:DeleteObject"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
    role       = aws_iam_role.bootstrap_role.name
    policy_arn = aws_iam_policy.s3_policy.arn
}

# Dynamodb policy

resource "aws_iam_policy" "dynamodb_policy" {
    name = "terraform-bootstrap-dynamodb-policy"
    description = "Policy to allow access to DynamoDB table for bootstrap"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "dynamodb:CreateTable",
                    "dynamodb:DeleteTable"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy_attachment" {
    role       = aws_iam_role.bootstrap_role.name
    policy_arn = aws_iam_policy.dynamodb_policy.arn
}

# Iam actions policy

resource "aws_iam_policy" "iam_actions_policy" {
    name = "terraform-bootstrap-iam-actions-policy"
    description = "Policy to allow access to IAM actions for bootstrap"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    # permissions with roles
                    "iam:CreateRole",
                    "iam:DeleteRole",
                    "iam:UpdateRole",          
                    "iam:UpdateRoleDescription",

                    # permissions with policies
                    "iam:CreatePolicy",
                    "iam:DeletePolicy",
                    "iam:AttachRolePolicy",
                    "iam:DetachRolePolicy",
                    "iam:UpdateAssumeRolePolicy"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "iam_actions_policy_attachment" {
    role       = aws_iam_role.bootstrap_role.name
    policy_arn = aws_iam_policy.iam_actions_policy.arn
}
