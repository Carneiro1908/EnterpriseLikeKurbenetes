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
                    "s3:CreateBucket",
                    "s3:DeleteBucket",

                    "s3:GetObject",
                    "s3:DeleteObject",
                    "s3:ListBucket",
                    "s3:PutObject",

                    "s3:PutBucketPublicAccessBlock",
                    "s3:PutBucketEncryption",
                    "s3:PutBucketVersioning",
                    "s3:GetBucketLocation",
                    "s3:ListBucket",

                    "s3:GetBucketPolicy",
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
                    "dynamodb:DeleteTable",
                    "dynamodb:DescribeTable",
                    "dynamodb:UpdateTable",
                    "dynamodb:PutItem",
                    "dynamodb:GetItem",
                    "dynamodb:DeleteItem",
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
                    "iam:GetRole",
                    "iam:CreateRole",
                    "iam:DeleteRole",
                    "iam:UpdateRole",          
                    "iam:UpdateRoleDescription",

                    # permissions with policies
                    "iam:CreatePolicy",
                    "iam:DeletePolicy",
                    "iam:AttachRolePolicy",
                    "iam:DetachRolePolicy",
                    "iam:UpdateAssumeRolePolicy",
                    "iam:GetPolicy",
                    "iam:GetPolicyVersion",
                    "iam:ListInstanceProfilesForRole",
                    "iam:ListRolePolicies",
                    "iam:ListAttachedRolePolicies"
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

# KMS policy
resource "aws_iam_policy" "kms_policy" {
    name = "terraform-bootstrap-kms-policy"
    description = "Policy to allow access to KMS for bootstrap"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    # permissions with keys
                    "kms:CreateKey",
                    "kms:DescribeKey",
                    "kms:ScheduleKeyDeletion",
                    "kms:CancelKeyDeletion",
                    "kms:EnableKeyRotation",
                    "kms:DisableKeyRotation",
                    "kms:ListKeys",
                    "kms:ListAliases",
                    "kms:CreateAlias",
                    "kms:Decrypt",
                    "kms:GenerateDataKey*",
                    "kms:DeleteAlias",
                    "kms:GetKeyPolicy"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "kms_policy_attachment" {
    role       = aws_iam_role.bootstrap_role.name
    policy_arn = aws_iam_policy.kms_policy.arn
}

# Adding tempo administrator policy
resource "aws_iam_policy" "admin_policy" {
    name = "terraform-bootstrap-admin-policy"
    description = "Policy to allow access to all resources for bootstrap"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "*"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}
resource "aws_iam_role_policy_attachment" "admin_policy_attachment" {
    role       = aws_iam_role.bootstrap_role.name
    policy_arn = aws_iam_policy.admin_policy.arn
}