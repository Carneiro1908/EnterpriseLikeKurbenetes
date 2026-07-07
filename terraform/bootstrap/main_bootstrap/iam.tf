resource "aws_iam_role" "github_main_infra_role" {
    name = "github_main_infra_role"
    assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

# Attaching policies to the role 

resource "aws_iam_policy" "github_main_infra_policy" {
    name = "github-main-infra-policy"

    policy = jsonencode( {
        "Version": "2012-10-17",
        "Statement": [
            
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
                    "s3:PutEncryptionConfiguration",
                    "s3:PutBucketVersioning",
                    "s3:PutBucketPublicAccessBlock",
                    "s3:GetBucketPublicAccessBlock"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateSubnet"
                ],
                "Resource": [
                    "*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateRouteTable"
                ],
                "Resource": [
                    "*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:DeleteNetworkAclEntry",
                    "ec2:CreateNetworkAclEntry"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:RevokeSecurityGroupEgress",
                    "ec2:RevokeSecurityGroupIngress"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateInternetGateway"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:AttachInternetGateway"
                ],
                "Resource": [
                    "*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "logs:CreateLogGroup",
                    "logs:ListTagsForResource"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:AssociateRouteTable",
                    "ec2:CreateRoute"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:AllocateAddress"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateFlowLogs"
                ],
                "Resource": [
                    "*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "iam:CreatePolicy"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateNatGateway"
                ],
                "Resource": "*"
            }
        ]
    })
}
resource "aws_iam_policy" "github_main_infra_policy2" {
    name = "github-main-infra-policy-2"

    policy = jsonencode( {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "sts:GetCallerIdentity",
                    "ec2:DescribeVpcs",
                    "ec2:DescribeNetworkAcls",
                    "ec2:DescribeRouteTables",
                    "ec2:DescribeSecurityGroups",
                    "ec2:DescribeSubnets",
                    "ec2:DescribeSecurityGroupRules",
                    "ec2:DescribeInternetGateways",
                    "ec2:AssociateRouteTable",
                    "ec2:CreateNatGateway",
                    "logs:DescribeLogGroups",
                    "ec2:DescribeAddresses",
                    "iam:PassRole",
                    "logs:CreateLogGroup",
                    "logs:TagResource",
                    "logs:CreateLogDelivery",
                    "ec2:DescribeAddressesAttribute",
                    "logs:CreateLogGroup", 
                    "ec2:DescribeFlowLogs",
                    "iam:GetPolicy",
                    "iam:TagRole",
                    "ec2:CreateTags",
                    "ec2:DescribeNatGateways",
                    "iam:GetPolicyVersion"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:ListBucket"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "dynamodb:PutItem",
                    "dynamodb:GetItem",
                    "dynamodb:DeleteItem"
                ],
                "Resource": ["*"]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:ListMultipartUploadParts",
                    "s3:PutObject"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "kms:DescribeKey",
                    "kms:GetKeyPolicy",
                    "kms:GetKeyRotationStatus",
                    "kms:ListResourceTags",
                    "kms:ScheduleKeyDeletion"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:GetBucketPublicAccessBlock",
                    "s3:ListBucket",
                    "s3:GetEncryptionConfiguration",
                    "s3:GetBucketVersioning",
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
                    "s3:PutBucketPublicAccessBlock",
                    "s3:PutBucketVersioning",
                    "s3:PutEncryptionConfiguration",
                    "s3:PutObject",
                    "s3:DeleteBucket"
                ],
                "Resource": ["*"]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "iam:GetRole",
                    "iam:ListAttachedRolePolicies",
                    "iam:ListRolePolicies",
                    "iam:CreateRole",
                    "iam:DetachRolePolicy",
                    "iam:ListInstanceProfilesForRole",
                    "iam:DeleteRole",
                    "iam:AttachRolePolicy"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "dynamodb:DescribeTable",
                    "dynamodb:DescribeContinuousBackups",
                    "dynamodb:DescribeTimeToLive",
                    "dynamodb:DeleteTable"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "kms:DescribeKey"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:ListTagsForResource"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ecr:CreateRepository",
                    "ecr:DescribeRepositories",
                    "ecr:ListTagsForResource",
                    "ecr:PutLifecyclePolicy",
                    "ecr:GetLifecyclePolicy"
                ],
                "Resource": "*"
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
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateVpc",
                    "ec2:ModifyVpcAttribute",
                    "ec2:DescribeVpcAttribute"
                ],
                "Resource": "*"
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
                    "s3:PutEncryptionConfiguration",
                    "s3:PutBucketVersioning",
                    "s3:PutBucketPublicAccessBlock",
                    "s3:GetBucketPublicAccessBlock"
                ],
                "Resource": "*"
            },
        ]
    })
}
resource "aws_iam_policy" "github_main_infra_policy3" {
  name = "github-main-infra-policy-3"

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

# attachments

resource "aws_iam_role_policy_attachment" "github_main_infra_role_policy_attachment" {
    role = aws_iam_role.github_main_infra_role.name
    policy_arn = aws_iam_policy.github_main_infra_policy.arn
}
resource "aws_iam_role_policy_attachment" "github_main_infra_role_policy_attachment2" {
    role = aws_iam_role.github_main_infra_role.name
    policy_arn = aws_iam_policy.github_main_infra_policy2.arn
}
resource "aws_iam_role_policy_attachment" "github_main_infra_role_policy_attachment3" {
    role = aws_iam_role.github_main_infra_role.name
    policy_arn = aws_iam_policy.github_main_infra_policy3.arn
}
