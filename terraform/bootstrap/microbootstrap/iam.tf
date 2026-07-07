resource "aws_iam_role" "bootstrap_role" {
  name               = "terraform-bootstrap-role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json

}

resource "aws_iam_role" "iamlive_role" {
  name               = "iamlive-role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

# attaching policies to terraform-bootstrap-role

resource "aws_iam_policy" "bootstrap_policy" {
  name        = "main-bootstrap-policy"
  description = "Policy for main bootstrap"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "sts:GetCallerIdentity",
          "kms:CreateKey",
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:CreateGrant",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:ListPolicyVersions",
          "iam:DeletePolicy",
          "ec2:DescribeVpcs",
          "ec2:DescribeNetworkAcls",
          "ec2:DescribeRouteTables",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroupRules",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeAddresses",
          "ec2:DescribeAddressesAttribute",
          "ec2:DescribeFlowLogs",
          "ec2:DescribeNatGateways",
          "logs:DescribeLogGroups",
          "ecr:DescribeRepositories",
          "ecr:GetLifecyclePolicy",
          "ecr:ListTagsForResource"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket"
        ],
        "Resource" : "arn:aws:s3:::terraform-main-bootstrap-bucket-eu-central-1"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DeleteItem"
        ],
        "Resource" : "arn:aws:dynamodb:eu-central-1:${local.account_id}:table/main_bootstrap_table"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource" : "arn:aws:s3:::terraform-main-bootstrap-bucket-eu-central-1/enviroment/bootstrap/terraform.tfstate"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:CreatePolicy"
        ],
        "Resource" : "arn:aws:iam::${local.account_id}:policy/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:CreateRole",
          "iam:GetRole",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:ListInstanceProfilesForRole",
          "iam:DeleteRole"
        ],
        "Resource" : "arn:aws:iam::${local.account_id}:role/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:CreateBucket",
          "s3:ListBucket",
          "s3:GetBucketPolicy",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketWebsite",
          "s3:GetBucketVersioning",
          "s3:GetAccelerateConfiguration",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketLogging",
          "s3:GetLifecycleConfiguration",
          "s3:GetReplicationConfiguration",
          "s3:GetEncryptionConfiguration",
          "s3:GetBucketObjectLockConfiguration",
          "s3:PutEncryptionConfiguration",
          "s3:PutBucketPublicAccessBlock",
          "s3:PutBucketVersioning",
          "s3:GetBucketPublicAccessBlock",
          "s3:DeleteBucket",
          "s3:GetBucketTagging"
        ],
        "Resource" : [
          "arn:aws:s3:::terraform-main-infra-bucket-eu-central-1",
          "arn:aws:s3:::terraform-env-*-bucket-eu-central-1"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:EnableKeyRotation",
          "kms:GetKeyRotationStatus",
          "kms:DescribeKey",
          "kms:GetKeyPolicy",
          "kms:ListResourceTags",
          "kms:ScheduleKeyDeletion"
        ],
        "Resource" : ["*"]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:CreateTable",
          "dynamodb:DescribeTable",
          "dynamodb:UpdateContinuousBackups",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:DeleteTable",
          "dynamodb:ListTagsOfResource"
        ],
        "Resource" : "arn:aws:dynamodb:eu-central-1:${local.account_id}:table/main_infra_table"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListTagsForResource"
        ],
        "Resource" : "arn:aws:s3:eu-central-1:${local.account_id}:access-grants/default"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:DescribeKey"
        ],
        "Resource" : ["*"]
      }
    ]

  })
}

resource "aws_iam_role_policy_attachment" "bootstrap_policy_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.bootstrap_policy.arn
}


# Adding read only policy for debbuger 
resource "aws_iam_role_policy_attachment" "readonly_policy_attachment" {
  role       = aws_iam_role.iamlive_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}