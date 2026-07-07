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
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:GetCallerIdentity",
                "ec2:DescribeRouteTables",
                "ec2:DescribeNatGateways",
                "ec2:DescribeAddresses",
                "ec2:DescribeInternetGateways",
                "ec2:DescribeSubnets",
                "logs:DescribeLogGroups",
                "iam:DeletePolicyVersion",
                "ec2:DescribeAddressesAttribute",
                "ec2:DescribeFlowLogs",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeVpcs",
                "ec2:DescribeNetworkAcls",
                "iam:GetPolicy",
                "iam:CreatePolicyVersion",
                "iam:GetPolicyVersion",
                "ec2:DescribeNetworkInterfaces",
                "kms:CreateKey",
                "iam:ListPolicyVersions",
                "iam:DeletePolicy",
                "ec2:ReleaseAddress"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::terraform-main-bootstrap-bucket-eu-central-1"
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:GetItem",
                "dynamodb:DeleteItem"
            ],
            "Resource": "arn:aws:dynamodb:eu-central-1:547320736290:table/main_bootstrap_table"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:GetObjectTagging",
                "s3:PutObjectTagging",
                "s3:PutObjectAcl"
            ],
            "Resource": "arn:aws:s3:::terraform-main-bootstrap-bucket-eu-central-1/enviroment/bootstrap/terraform.tfstate"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:ListAttachedRolePolicies",
                "iam:GetRole",
                "iam:ListRolePolicies",
                "iam:DetachRolePolicy",
                "iam:ListInstanceProfilesForRole",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:AttachRolePolicy"
            ],
            "Resource": "arn:aws:iam::547320736290:role/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketVersioning",
                "s3:GetEncryptionConfiguration",
                "s3:ListBucket",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketPolicy",
                "s3:GetBucketAcl",
                "s3:GetBucketCORS",
                "s3:GetBucketWebsite",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketLogging",
                "s3:GetLifecycleConfiguration",
                "s3:GetReplicationConfiguration",
                "s3:GetBucketObjectLockConfiguration",
                "s3:PutEncryptionConfiguration",
                "s3:PutBucketVersioning",
                "s3:PutBucketPublicAccessBlock",
                "s3:DeleteBucket"
            ],
            "Resource": "arn:aws:s3:::terraform-env-prod-bucket-eu-central-1"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketVersioning",
                "s3:ListBucket",
                "s3:GetBucketPolicy",
                "s3:GetBucketAcl",
                "s3:GetBucketCORS",
                "s3:GetEncryptionConfiguration",
                "s3:GetBucketWebsite",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketLogging",
                "s3:GetLifecycleConfiguration",
                "s3:GetReplicationConfiguration",
                "s3:GetBucketObjectLockConfiguration",
                "s3:PutBucketVersioning",
                "s3:PutBucketPublicAccessBlock",
                "s3:PutEncryptionConfiguration",
                "s3:DeleteBucket"
            ],
            "Resource": "arn:aws:s3:::terraform-env-staging-bucket-eu-central-1"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:ListTagsForResource",
                "logs:DeleteLogGroup"
            ],
            "Resource": "arn:aws:logs:eu-central-1:547320736290:log-group:/aws/vpc-flow-log/vpc-037eaef4c80501c2e"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketVersioning",
                "s3:GetBucketPolicy",
                "s3:GetBucketAcl",
                "s3:GetEncryptionConfiguration",
                "s3:GetBucketCORS",
                "s3:GetBucketWebsite",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketLogging",
                "s3:GetLifecycleConfiguration",
                "s3:GetReplicationConfiguration",
                "s3:GetBucketObjectLockConfiguration",
                "s3:PutEncryptionConfiguration",
                "s3:PutBucketPublicAccessBlock",
                "s3:PutBucketVersioning",
                "s3:DeleteBucket"
            ],
            "Resource": "arn:aws:s3:::terraform-env-dev-bucket-eu-central-1"
        }
        
      ]
  })
}

resource "aws_iam_policy" "bootstrap_policy2" {
  name = "bootstrap-policy-2"

  policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
            "Effect": "Allow",
            "Action": [
                "ecr:DescribeRepositories",
                "ecr:ListTagsForResource",
                "ecr:GetLifecyclePolicy",
                "ecr:DeleteLifecyclePolicy",
                "ecr:DeleteRepository",
            ],
            "Resource": "arn:aws:ecr:eu-central-1:547320736290:repository/app-container-repository"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVpcAttribute",
                "ec2:DeleteVpc"
            ],
            "Resource": "arn:aws:ec2:eu-central-1:547320736290:vpc/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListTagsForResource"
            ],
            "Resource": "arn:aws:s3:eu-central-1:547320736290:access-grants/default"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DisassociateRouteTable"
            ],
            "Resource": [
                "arn:aws:ec2:eu-central-1:547320736290:route-table/*",
                "arn:aws:ec2:eu-central-1:547320736290:subnet/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DeleteRoute",
                "ec2:DeleteRouteTable"
            ],
            "Resource": "arn:aws:ec2:eu-central-1:547320736290:route-table/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DeleteFlowLogs"
            ],
            "Resource": "arn:aws:ec2:eu-central-1:547320736290:vpc-flow-log/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy"
            ],
            "Resource": "arn:aws:iam::547320736290:policy/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DeleteSubnet"
            ],
            "Resource": "arn:aws:ec2:eu-central-1:547320736290:subnet/*"
        },
        {
            "Effect": "Allow",
            "Action": [
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
                "s3:PutBucketVersioning",
                "s3:PutEncryptionConfiguration",
                "s3:PutBucketPublicAccessBlock",
                "s3:GetBucketPublicAccessBlock"
            ],
            "Resource": "arn:aws:s3:::terraform-main-infra-bucket-eu-central-1"
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:EnableKeyRotation",
                "kms:GetKeyRotationStatus",
                "kms:DescribeKey",
                "kms:GetKeyPolicy",
                "kms:ListResourceTags"
            ],
            "Resource": "arn:aws:kms:eu-central-1:547320736290:key/877fe9b9-b190-4dd0-8e84-dece5a0c8d61"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DeleteNatGateway"
            ],
            "Resource": "arn:aws:ec2:eu-central-1:547320736290:natgateway/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:CreateTable",
                "dynamodb:DescribeTable",
                "dynamodb:UpdateContinuousBackups",
                "dynamodb:DescribeContinuousBackups",
                "dynamodb:DescribeTimeToLive"
            ],
            "Resource": "arn:aws:dynamodb:eu-central-1:547320736290:table/main_infra_table"
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:DescribeKey"
            ],
            "Resource": "arn:aws:kms:eu-central-1:547320736290:key/alias/aws/dynamodb"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DisassociateAddress"
            ],
            "Resource": [
                "arn:aws:ec2:eu-central-1:547320736290:elastic-ip/*",
                "arn:aws:ec2:eu-central-1:547320736290:network-interface/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DetachInternetGateway"
            ],
            "Resource": [
                "arn:aws:ec2:eu-central-1:547320736290:internet-gateway/*",
                "arn:aws:ec2:eu-central-1:547320736290:vpc/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DeleteInternetGateway"
            ],
            "Resource": "arn:aws:ec2:eu-central-1:547320736290:internet-gateway/*"
        }
    ]
  }
  )
}

resource "aws_iam_policy" "bootstrap_policy3" {
  name = "bootstrap-policy-3"

  policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt",
          "dynamodb:ListTagsOfResource",
          "s3:GetBucketTagging"
        ],
        "Resource": ["*"]
      }
    ]
  })
}


# Attachments
resource "aws_iam_role_policy_attachment" "bootstrap_policy_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.bootstrap_policy.arn
}
resource "aws_iam_role_policy_attachment" "bootstrap_policy_attachment2" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.bootstrap_policy2.arn
}
resource "aws_iam_role_policy_attachment" "bootstrap_policy_attachment3" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.bootstrap_policy3.arn
}

# Adding read only policy for debbuger 
resource "aws_iam_role_policy_attachment" "readonly_policy_attachment" {
  role       = aws_iam_role.iamlive_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}