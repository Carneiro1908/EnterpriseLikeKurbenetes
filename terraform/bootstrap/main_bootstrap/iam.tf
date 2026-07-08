# IAM Role

resource "aws_iam_role" "github_main_infra_role" {
  name               = "github_main_infra_role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}


# S3 bucket configuration (create/get/put)

resource "aws_iam_policy" "infra_s3_bucket_config_policy" {
  name        = "infra-s3-bucket-config-policy"
  description = "Create and configure an S3 backend bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Subnet - creation

resource "aws_iam_policy" "infra_subnet_create_policy" {
  name        = "infra-subnet-create-policy"
  description = "Create subnets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:CreateSubnet"]
        Resource = ["*"]
      }
    ]
  })
}

# Route table - creation

resource "aws_iam_policy" "infra_route_table_create_policy" {
  name        = "infra-route-table-create-policy"
  description = "Create route tables"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:CreateRouteTable"]
        Resource = ["*"]
      }
    ]
  })
}

# Network ACL entries

resource "aws_iam_policy" "infra_network_acl_entry_policy" {
  name        = "infra-network-acl-entry-policy"
  description = "Create and delete network ACL entries"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DeleteNetworkAclEntry",
          "ec2:CreateNetworkAclEntry"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Security group - revoke rules

resource "aws_iam_policy" "infra_security_group_revoke_policy" {
  name        = "infra-security-group-revoke-policy"
  description = "Revoke security group egress/ingress rules"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:RevokeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupIngress"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Internet Gateway - creation

resource "aws_iam_policy" "infra_igw_create_policy" {
  name        = "infra-igw-create-policy"
  description = "Create Internet Gateways"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:CreateInternetGateway"]
        Resource = ["*"]
      }
    ]
  })
}

# Internet Gateway - attach

resource "aws_iam_policy" "infra_igw_attach_policy" {
  name        = "infra-igw-attach-policy"
  description = "Attach Internet Gateways to VPCs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:AttachInternetGateway"]
        Resource = ["*"]
      }
    ]
  })
}

# Log group - creation and tags

resource "aws_iam_policy" "infra_log_group_create_policy" {
  name        = "infra-log-group-create-policy"
  description = "Create log groups and read their tags"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:ListTagsForResource"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Route table - associate and create route

resource "aws_iam_policy" "infra_route_create_policy" {
  name        = "infra-route-create-policy"
  description = "Associate route tables and create routes"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:AssociateRouteTable",
          "ec2:CreateRoute"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Elastic IP - allocation

resource "aws_iam_policy" "infra_eip_allocate_policy" {
  name        = "infra-eip-allocate-policy"
  description = "Allocate Elastic IPs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:AllocateAddress"]
        Resource = ["*"]
      }
    ]
  })
}

# VPC flow logs - creation

resource "aws_iam_policy" "infra_flow_logs_create_policy" {
  name        = "infra-flow-logs-create-policy"
  description = "Create VPC flow logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:CreateFlowLogs"]
        Resource = ["*"]
      }
    ]
  })
}

# IAM - create policies

resource "aws_iam_policy" "infra_iam_create_policy_policy" {
  name        = "infra-iam-create-policy-policy"
  description = "Create new IAM policies"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["iam:CreatePolicy"]
        Resource = ["*"]
      }
    ]
  })
}

# NAT Gateway - creation

resource "aws_iam_policy" "infra_nat_gateway_create_policy" {
  name        = "infra-nat-gateway-create-policy"
  description = "Create NAT gateways"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:CreateNatGateway"]
        Resource = ["*"]
      }
    ]
  })
}

# General describe / read-only actions

resource "aws_iam_policy" "infra_general_describe_policy" {
  name        = "infra-general-describe-policy"
  description = "General describe/read-only actions used across main infra"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
        ]
        Resource = ["*"]
      }
    ]
  })
}

# S3 bucket - list

resource "aws_iam_policy" "infra_s3_list_bucket_policy" {
  name        = "infra-s3-list-bucket-policy"
  description = "List access to an S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = ["*"]
      }
    ]
  })
}

# DynamoDB - state lock table items

resource "aws_iam_policy" "infra_dynamodb_item_policy" {
  name        = "infra-dynamodb-item-policy"
  description = "Read/write/delete items on the state lock table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DeleteItem"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# S3 - multipart upload / put object

resource "aws_iam_policy" "infra_s3_multipart_upload_policy" {
  name        = "infra-s3-multipart-upload-policy"
  description = "Upload objects and multipart upload parts"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListMultipartUploadParts",
          "s3:PutObject"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# KMS key - info and scheduled deletion

resource "aws_iam_policy" "infra_kms_key_info_policy" {
  name        = "infra-kms-key-info-policy"
  description = "Describe key, policy, rotation status, tags, and schedule deletion"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:DescribeKey",
          "kms:GetKeyPolicy",
          "kms:GetKeyRotationStatus",
          "kms:ListResourceTags",
          "kms:ScheduleKeyDeletion"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# S3 bucket - full read/write operations

resource "aws_iam_policy" "infra_s3_bucket_full_ops_policy" {
  name        = "infra-s3-bucket-full-ops-policy"
  description = "Full read/write operations on an S3 bucket, including object upload"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
        ]
        Resource = ["*"]
      }
    ]
  })
}

# IAM role management

resource "aws_iam_policy" "infra_iam_role_management_policy" {
  name        = "infra-iam-role-management-policy"
  description = "Create, inspect, and delete IAM roles and their attachments"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:GetRole",
          "iam:ListAttachedRolePolicies",
          "iam:ListRolePolicies",
          "iam:CreateRole",
          "iam:DetachRolePolicy",
          "iam:ListInstanceProfilesForRole",
          "iam:DeleteRole",
          "iam:AttachRolePolicy"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# DynamoDB table - describe and delete

resource "aws_iam_policy" "infra_dynamodb_table_describe_delete_policy" {
  name        = "infra-dynamodb-table-describe-delete-policy"
  description = "Describe and delete a DynamoDB table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:DescribeTable",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:DeleteTable"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# KMS - describe key

resource "aws_iam_policy" "infra_kms_describe_key_policy" {
  name        = "infra-kms-describe-key-policy"
  description = "Describe a KMS key"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["kms:DescribeKey"]
        Resource = ["*"]
      }
    ]
  })
}

# S3 - list tags for resource

resource "aws_iam_policy" "infra_s3_list_tags_policy" {
  name        = "infra-s3-list-tags-policy"
  description = "Read tags on an S3 resource"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListTagsForResource"]
        Resource = ["*"]
      }
    ]
  })
}

# ECR repository - creation and configuration

resource "aws_iam_policy" "infra_ecr_repository_create_policy" {
  name        = "infra-ecr-repository-create-policy"
  description = "Create and configure an ECR repository"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:CreateRepository",
          "ecr:DescribeRepositories",
          "ecr:ListTagsForResource",
          "ecr:PutLifecyclePolicy",
          "ecr:GetLifecyclePolicy"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# S3 bucket configuration (create/get) - second bucket

resource "aws_iam_policy" "infra_s3_bucket_config_policy2" {
  name        = "infra-s3-bucket-config-policy-2"
  description = "Create and configure a second S3 backend bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
        ]
        Resource = ["*"]
      }
    ]
  })
}

# VPC - creation

resource "aws_iam_policy" "infra_vpc_create_policy" {
  name        = "infra-vpc-create-policy"
  description = "Create a VPC and modify/describe its attributes"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateVpc",
          "ec2:ModifyVpcAttribute",
          "ec2:DescribeVpcAttribute"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# S3 bucket configuration (create/get) - third bucket

resource "aws_iam_policy" "infra_s3_bucket_config_policy3" {
  name        = "infra-s3-bucket-config-policy-3"
  description = "Create and configure a third S3 backend bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Cross-cutting KMS decrypt / tag-reading actions

resource "aws_iam_policy" "infra_cross_cutting_policy" {
  name        = "infra-cross-cutting-policy"
  description = "KMS decrypt and tag-reading actions required across multiple services"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "dynamodb:ListTagsOfResource",
          "s3:GetBucketTagging"
        ]
        Resource = ["*"]
      }
    ]
  })
}


# Policy Attachments - github_main_infra_role

resource "aws_iam_role_policy_attachment" "infra_s3_bucket_config_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_s3_bucket_config_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_subnet_create_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_subnet_create_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_route_table_create_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_route_table_create_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_network_acl_entry_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_network_acl_entry_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_security_group_revoke_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_security_group_revoke_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_igw_create_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_igw_create_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_igw_attach_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_igw_attach_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_log_group_create_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_log_group_create_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_route_create_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_route_create_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_eip_allocate_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_eip_allocate_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_flow_logs_create_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_flow_logs_create_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_iam_create_policy_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_iam_create_policy_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_nat_gateway_create_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_nat_gateway_create_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_general_describe_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_general_describe_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_s3_list_bucket_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_s3_list_bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_dynamodb_item_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_dynamodb_item_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_s3_multipart_upload_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_s3_multipart_upload_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_kms_key_info_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_kms_key_info_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_s3_bucket_full_ops_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_s3_bucket_full_ops_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_iam_role_management_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_iam_role_management_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_dynamodb_table_describe_delete_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_dynamodb_table_describe_delete_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_kms_describe_key_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_kms_describe_key_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_s3_list_tags_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_s3_list_tags_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_ecr_repository_create_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_ecr_repository_create_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_s3_bucket_config_attachment2" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_s3_bucket_config_policy2.arn
}

resource "aws_iam_role_policy_attachment" "infra_vpc_create_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_vpc_create_policy.arn
}

resource "aws_iam_role_policy_attachment" "infra_s3_bucket_config_attachment3" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_s3_bucket_config_policy3.arn
}

resource "aws_iam_role_policy_attachment" "infra_cross_cutting_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = aws_iam_policy.infra_cross_cutting_policy.arn
}
