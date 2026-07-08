
# IAM Roles

resource "aws_iam_role" "bootstrap_role" {
  name               = "terraform-bootstrap-role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

resource "aws_iam_role" "iamlive_role" {
  name               = "iamlive-role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}


# General describe / read-only actions

resource "aws_iam_policy" "general_describe_policy" {
  name        = "bootstrap-general-describe-policy"
  description = "General describe/read-only actions used across the bootstrap process"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
          "ec2:ReleaseAddress",
          "kms:CreateGrant"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Bootstrap S3 bucket - list access

resource "aws_iam_policy" "bootstrap_bucket_list_policy" {
  name        = "bootstrap-bucket-list-policy"
  description = "List access to the bootstrap backend bucket"

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

# Bootstrap DynamoDB lock table

resource "aws_iam_policy" "bootstrap_dynamodb_policy" {
  name        = "bootstrap-dynamodb-policy"
  description = "Access to the bootstrap state lock table"

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

# Bootstrap state file - read/write access

resource "aws_iam_policy" "bootstrap_state_file_policy" {
  name        = "bootstrap-state-file-policy"
  description = "Read/write access to the bootstrap terraform state file"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectTagging",
          "s3:PutObjectTagging",
          "s3:PutObjectAcl"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# IAM role management

resource "aws_iam_policy" "iam_role_management_policy" {
  name        = "bootstrap-iam-role-management-policy"
  description = "Create, inspect, and delete IAM roles and their attachments"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:ListAttachedRolePolicies",
          "iam:GetRole",
          "iam:ListRolePolicies",
          "iam:DetachRolePolicy",
          "iam:ListInstanceProfilesForRole",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:AttachRolePolicy"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Prod environment backend bucket

resource "aws_iam_policy" "prod_bucket_policy" {
  name        = "bootstrap-prod-bucket-policy"
  description = "Access to the prod environment backend bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Staging environment backend bucket

resource "aws_iam_policy" "staging_bucket_policy" {
  name        = "bootstrap-staging-bucket-policy"
  description = "Access to the staging environment backend bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Dev environment backend bucket

resource "aws_iam_policy" "dev_bucket_policy" {
  name        = "bootstrap-dev-bucket-policy"
  description = "Access to the dev environment backend bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
        ]
        Resource = ["*"]
      }
    ]
  })
}

# Main infra backend bucket

resource "aws_iam_policy" "main_infra_bucket_policy" {
  name        = "bootstrap-main-infra-bucket-policy"
  description = "Access to the main infra backend bucket"

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

# VPC flow log group

resource "aws_iam_policy" "flow_log_group_policy" {
  name        = "bootstrap-flow-log-group-policy"
  description = "Tags and deletion access for the VPC flow log group"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:ListTagsForResource",
          "logs:DeleteLogGroup"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# ECR repository

resource "aws_iam_policy" "ecr_repository_policy" {
  name        = "bootstrap-ecr-repository-policy"
  description = "Describe, tag, lifecycle policy, and delete access for the ECR repository"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:DescribeRepositories",
          "ecr:ListTagsForResource",
          "ecr:GetLifecyclePolicy",
          "ecr:DeleteLifecyclePolicy",
          "ecr:DeleteRepository"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# VPC - describe and delete

resource "aws_iam_policy" "vpc_policy" {
  name        = "bootstrap-vpc-policy"
  description = "Describe attributes and delete access for the VPC"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeVpcAttribute",
          "ec2:DeleteVpc"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# S3 access grants tags

resource "aws_iam_policy" "s3_access_grants_policy" {
  name        = "bootstrap-s3-access-grants-policy"
  description = "Read tags on S3 access grants"

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

# Route table - disassociate

resource "aws_iam_policy" "route_table_disassociate_policy" {
  name        = "bootstrap-route-table-disassociate-policy"
  description = "Disassociate route tables from subnets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:DisassociateRouteTable"]
        Resource = ["*"]
      }
    ]
  })
}

# Route table - delete routes and route tables

resource "aws_iam_policy" "route_table_delete_policy" {
  name        = "bootstrap-route-table-delete-policy"
  description = "Delete routes and route tables"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DeleteRoute",
          "ec2:DeleteRouteTable"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# VPC flow logs - deletion

resource "aws_iam_policy" "flow_logs_delete_policy" {
  name        = "bootstrap-flow-logs-delete-policy"
  description = "Delete VPC flow logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:DeleteFlowLogs"]
        Resource = ["*"]
      }
    ]
  })
}

# IAM - create policies

resource "aws_iam_policy" "iam_create_policy_policy" {
  name        = "bootstrap-iam-create-policy-policy"
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

# Subnet - deletion

resource "aws_iam_policy" "subnet_delete_policy" {
  name        = "bootstrap-subnet-delete-policy"
  description = "Delete subnets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:DeleteSubnet"]
        Resource = ["*"]
      }
    ]
  })
}

# KMS key (main infra)

resource "aws_iam_policy" "kms_main_infra_policy" {
  name        = "bootstrap-kms-main-infra-policy"
  description = "Rotation status, policy, and tags for the main infra KMS key"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:EnableKeyRotation",
          "kms:GetKeyRotationStatus",
          "kms:DescribeKey",
          "kms:GetKeyPolicy",
          "kms:ListResourceTags"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# NAT Gateway - deletion

resource "aws_iam_policy" "nat_gateway_delete_policy" {
  name        = "bootstrap-nat-gateway-delete-policy"
  description = "Delete NAT gateways"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:DeleteNatGateway"]
        Resource = ["*"]
      }
    ]
  })
}

# Main infra DynamoDB lock table

resource "aws_iam_policy" "main_infra_dynamodb_policy" {
  name        = "bootstrap-main-infra-dynamodb-policy"
  description = "Access to the main infra state lock table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:CreateTable",
          "dynamodb:DescribeTable",
          "dynamodb:UpdateContinuousBackups",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeTimeToLive"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# DynamoDB default AWS-managed KMS key

resource "aws_iam_policy" "kms_dynamodb_alias_policy" {
  name        = "bootstrap-kms-dynamodb-alias-policy"
  description = "Describe access for the default AWS-managed DynamoDB KMS key"

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

# Elastic IP - disassociate

resource "aws_iam_policy" "eip_disassociate_policy" {
  name        = "bootstrap-eip-disassociate-policy"
  description = "Disassociate Elastic IPs from network interfaces"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:DisassociateAddress"]
        Resource = ["*"]
      }
    ]
  })
}

# Internet Gateway - detach

resource "aws_iam_policy" "igw_detach_policy" {
  name        = "bootstrap-igw-detach-policy"
  description = "Detach Internet Gateways from VPCs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:DetachInternetGateway"]
        Resource = ["*"]
      }
    ]
  })
}

# Internet Gateway - deletion

resource "aws_iam_policy" "igw_delete_policy" {
  name        = "bootstrap-igw-delete-policy"
  description = "Delete Internet Gateways"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:DeleteInternetGateway"]
        Resource = ["*"]
      }
    ]
  })
}

# Cross-cutting KMS decrypt / tag-reading actions

resource "aws_iam_policy" "cross_cutting_policy" {
  name        = "bootstrap-cross-cutting-policy"
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


# Policy Attachments - terraform-bootstrap-role

resource "aws_iam_role_policy_attachment" "general_describe_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.general_describe_policy.arn
}

resource "aws_iam_role_policy_attachment" "bootstrap_bucket_list_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.bootstrap_bucket_list_policy.arn
}

resource "aws_iam_role_policy_attachment" "bootstrap_dynamodb_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.bootstrap_dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "bootstrap_state_file_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.bootstrap_state_file_policy.arn
}

resource "aws_iam_role_policy_attachment" "iam_role_management_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.iam_role_management_policy.arn
}

resource "aws_iam_role_policy_attachment" "prod_bucket_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.prod_bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "staging_bucket_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.staging_bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "dev_bucket_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.dev_bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "main_infra_bucket_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.main_infra_bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "flow_log_group_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.flow_log_group_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecr_repository_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.ecr_repository_policy.arn
}

resource "aws_iam_role_policy_attachment" "vpc_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.vpc_policy.arn
}

resource "aws_iam_role_policy_attachment" "s3_access_grants_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.s3_access_grants_policy.arn
}

resource "aws_iam_role_policy_attachment" "route_table_disassociate_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.route_table_disassociate_policy.arn
}

resource "aws_iam_role_policy_attachment" "route_table_delete_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.route_table_delete_policy.arn
}

resource "aws_iam_role_policy_attachment" "flow_logs_delete_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.flow_logs_delete_policy.arn
}

resource "aws_iam_role_policy_attachment" "iam_create_policy_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.iam_create_policy_policy.arn
}

resource "aws_iam_role_policy_attachment" "subnet_delete_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.subnet_delete_policy.arn
}

resource "aws_iam_role_policy_attachment" "kms_main_infra_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.kms_main_infra_policy.arn
}

resource "aws_iam_role_policy_attachment" "nat_gateway_delete_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.nat_gateway_delete_policy.arn
}

resource "aws_iam_role_policy_attachment" "main_infra_dynamodb_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.main_infra_dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "kms_dynamodb_alias_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.kms_dynamodb_alias_policy.arn
}

resource "aws_iam_role_policy_attachment" "eip_disassociate_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.eip_disassociate_policy.arn
}

resource "aws_iam_role_policy_attachment" "igw_detach_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.igw_detach_policy.arn
}

resource "aws_iam_role_policy_attachment" "igw_delete_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.igw_delete_policy.arn
}

resource "aws_iam_role_policy_attachment" "cross_cutting_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.cross_cutting_policy.arn
}

# Policy Attachments - iamlive-role (debugger)

# Read-only policy for the iamlive debugger role
resource "aws_iam_role_policy_attachment" "readonly_policy_attachment" {
  role       = aws_iam_role.iamlive_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
