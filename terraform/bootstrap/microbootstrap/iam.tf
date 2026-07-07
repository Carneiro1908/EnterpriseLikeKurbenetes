resource "aws_iam_role" "bootstrap_role" {
    name = "terraform-bootstrap-role"
    assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json

}

resource "aws_iam_role" "iamlive_role" {
    name = "iamlive-role"
    assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

# attaching policies to terraform-bootstrap-role

resource "aws_iam_policy" "bootstrap_policy" {
  name        = "main-bootstrap-policy"
  description = "Policy for main bootstrap"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["sts:GetCallerIdentity", "iam:GetPolicy", "iam:GetPolicyVersion", "iam:ListPolicyVersions", "iam:DeletePolicy"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = "arn:aws:s3:::terraform-main-bootstrap-bucket-eu-central-1"
      },
      {
        Effect   = "Allow"
        Action   = ["dynamodb:PutItem", "dynamodb:GetItem", "dynamodb:DeleteItem"]
        Resource = "arn:aws:dynamodb:eu-central-1:547320736290:table/main_bootstrap_table"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:ListMultipartUploadParts", "s3:PutObject"]
        Resource = "arn:aws:s3:::terraform-main-bootstrap-bucket-eu-central-1/enviroment/bootstrap/terraform.tfstate"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket", "s3:GetBucketPolicy", "s3:GetBucketAcl", "s3:GetBucketCORS",
          "s3:GetBucketWebsite", "s3:GetBucketVersioning", "s3:GetAccelerateConfiguration",
          "s3:GetBucketRequestPayment", "s3:GetBucketLogging", "s3:GetLifecycleConfiguration",
          "s3:GetReplicationConfiguration", "s3:GetEncryptionConfiguration",
          "s3:GetBucketObjectLockConfiguration", "s3:GetBucketPublicAccessBlock",
          "s3:PutBucketVersioning", "s3:PutBucketPublicAccessBlock",
          "s3:PutEncryptionConfiguration", "s3:DeleteBucket"
        ]
        Resource = "arn:aws:s3:::terraform-main-infra-bucket-eu-central-1"
      },
      {
        Effect   = "Allow"
        Action   = ["kms:DescribeKey", "kms:GetKeyPolicy", "kms:GetKeyRotationStatus", "kms:ListResourceTags", "kms:ScheduleKeyDeletion"]
        Resource = ["*"]
      },
      {
        Effect   = "Allow"
        Action   = ["iam:GetRole", "iam:ListRolePolicies", "iam:ListAttachedRolePolicies", "iam:DetachRolePolicy", "iam:ListInstanceProfilesForRole", "iam:DeleteRole"]
        Resource = "arn:aws:iam::547320736290:role/*"
      },
      {
        Effect   = "Allow"
        Action   = ["dynamodb:DescribeTable", "dynamodb:DescribeContinuousBackups", "dynamodb:DescribeTimeToLive", "dynamodb:DeleteTable"]
        Resource = "arn:aws:dynamodb:eu-central-1:547320736290:table/main_infra_table"
      },
      {
        Effect   = "Allow"
        Action   = ["kms:DescribeKey"]
        Resource = "arn:aws:kms:eu-central-1:547320736290:key/alias/aws/dynamodb"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:ListTagsForResource"]
        Resource = "arn:aws:s3:eu-central-1:547320736290:access-grants/default"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bootstrap_policy_attachment" {
    role = aws_iam_role.bootstrap_role.name  
    policy_arn = aws_iam_policy.bootstrap_policy.arn
}


# Adding read only policy for debbuger 
resource "aws_iam_role_policy_attachment" "readonly_policy_attachment" {
    role = aws_iam_role.iamlive_role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}