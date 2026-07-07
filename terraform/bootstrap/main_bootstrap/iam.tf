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
                    "sts:GetCallerIdentity",
                    "ec2:DescribeVpcs",
                    "ec2:DescribeNetworkAcls",
                    "ec2:DescribeRouteTables",
                    "ec2:DescribeSecurityGroups",
                    "ec2:DescribeSubnets",
                    "ec2:DescribeSecurityGroupRules",
                    "ec2:DescribeInternetGateways",
                    "logs:DescribeLogGroups",
                    "ec2:DescribeAddresses",
                    "iam:PassRole",
                    "logs:CreateLogDelivery",
                    "ec2:DescribeAddressesAttribute",
                    "ec2:DescribeFlowLogs",
                    "iam:GetPolicy",
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
                    "s3:ListMultipartUploadParts",
                    "s3:PutObject"
                ],
                "Resource": "arn:aws:s3:::terraform-main-bootstrap-bucket-eu-central-1/enviroment/bootstrap/terraform.tfstate"
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
                "Resource": "arn:aws:kms:eu-central-1:547320736290:key/97f226da-5643-4490-a832-5a8458e88f91"
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
                    "s3:DeleteBucket"
                ],
                "Resource": "arn:aws:s3:::terraform-main-infra-bucket-eu-central-1"
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
                "Resource": "arn:aws:iam::547320736290:role/*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "dynamodb:DescribeTable",
                    "dynamodb:DescribeContinuousBackups",
                    "dynamodb:DescribeTimeToLive",
                    "dynamodb:DeleteTable"
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
                    "s3:ListTagsForResource"
                ],
                "Resource": "arn:aws:s3:eu-central-1:547320736290:access-grants/default"
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
                "Resource": "arn:aws:ecr:eu-central-1:547320736290:repository/app-container-repository"
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
                "Resource": "arn:aws:s3:::terraform-env-prod-bucket-eu-central-1"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateVpc",
                    "ec2:ModifyVpcAttribute",
                    "ec2:DescribeVpcAttribute"
                ],
                "Resource": "arn:aws:ec2:eu-central-1:547320736290:vpc/*"
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
                "Resource": "arn:aws:s3:::terraform-env-staging-bucket-eu-central-1"
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
                "Resource": "arn:aws:s3:::terraform-env-dev-bucket-eu-central-1"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateSubnet"
                ],
                "Resource": [
                    "arn:aws:ec2:eu-central-1:547320736290:subnet/*",
                    "arn:aws:ec2:eu-central-1:547320736290:vpc/*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateRouteTable"
                ],
                "Resource": [
                    "arn:aws:ec2:eu-central-1:547320736290:route-table/*",
                    "arn:aws:ec2:eu-central-1:547320736290:vpc/*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:DeleteNetworkAclEntry",
                    "ec2:CreateNetworkAclEntry"
                ],
                "Resource": "arn:aws:ec2:eu-central-1:547320736290:network-acl/*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:RevokeSecurityGroupEgress",
                    "ec2:RevokeSecurityGroupIngress"
                ],
                "Resource": "arn:aws:ec2:eu-central-1:547320736290:security-group/*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateInternetGateway"
                ],
                "Resource": "arn:aws:ec2:eu-central-1:547320736290:internet-gateway/*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:AttachInternetGateway"
                ],
                "Resource": [
                    "arn:aws:ec2:eu-central-1:547320736290:internet-gateway/*",
                    "arn:aws:ec2:eu-central-1:547320736290:vpc/*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "logs:CreateLogGroup",
                    "logs:ListTagsForResource"
                ],
                "Resource": "arn:aws:logs:eu-central-1:547320736290:log-group:/aws/vpc-flow-log/vpc-037eaef4c80501c2e"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:AssociateRouteTable",
                    "ec2:CreateRoute"
                ],
                "Resource": "arn:aws:ec2:eu-central-1:547320736290:route-table/*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:AllocateAddress"
                ],
                "Resource": "arn:aws:ec2:eu-central-1:547320736290:elastic-ip/*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateFlowLogs"
                ],
                "Resource": [
                    "arn:aws:ec2:eu-central-1:547320736290:network-interface/*",
                    "arn:aws:ec2:eu-central-1:547320736290:subnet/*",
                    "arn:aws:ec2:eu-central-1:547320736290:vpc-flow-log/*",
                    "arn:aws:ec2:eu-central-1:547320736290:vpc/*"
                ]
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
                    "ec2:CreateNatGateway"
                ],
                "Resource": "arn:aws:ec2:eu-central-1:547320736290:natgateway/*"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "github_main_infra_role_policy_attachment" {
    role = aws_iam_role.github_main_infra_role.name
    policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
