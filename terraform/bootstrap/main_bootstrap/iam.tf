resource "aws_iam_role" "github_main_infra_role" {
    name = "github_main_infra_role"
    assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

# Attaching policies to the role

# S3 permissions
resource "aws_iam_policy" "github_oidc_role_s3_policy" {
    name = "github_main_infra_role_s3_policies"
    description = "Policy to allow access to S3 bucket for main infra"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
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
resource "aws_iam_role_policy_attachment" "github_oidc_role_s3_policy_attachment" {
    role       = aws_iam_role.github_main_infra_role.name
    policy_arn = aws_iam_policy.github_oidc_role_s3_policy.arn
}

# EKS permissions
resource "aws_iam_policy" "github_oidc_role_eks_policy" {
    name = "github_main_infra_role_eks_policies"
    description = "Policy to allow access to EKS cluster for main infra"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    # permissions with EKS cluster
                    "eks:CreateCluster",
                    "eks:DescribeCluster",
                    "eks:UpdateClusterConfig",
                    "eks:UpdateClusterVersion",
                    "eks:DeleteCluster",
                    "eks:ListClusters",
                    "eks:CreateNodegroup",
                    "eks:DescribeNodegroup",
                    "eks:UpdateNodegroupConfig",
                    "eks:UpdateNodegroupVersion",
                    "eks:DeleteNodegroup",
                    "eks:ListNodegroups",
                    "eks:CreateAddon",
                    "eks:DescribeAddon",
                    "eks:UpdateAddon",
                    "eks:DeleteAddon",
                    "eks:CreateAccessEntry",
                    "eks:DescribeAccessEntry",
                    "eks:UpdateAccessEntry",
                    "eks:DeleteAccessEntry",
                    "eks:AssociateAccessPolicy",
                    "eks:DisassociateAccessPolicy"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}
resource "aws_iam_role_policy_attachment" "github_oidc_role_eks_policy_attachment" {
    role       = aws_iam_role.github_main_infra_role.name
    policy_arn = aws_iam_policy.github_oidc_role_eks_policy.arn
}

# IAM permissions (needed for building EKS & roles for workflows)
resource "aws_iam_policy" "github_oidc_role_iam_policy" {
    name = "github_main_infra_role_iam_policies"
    description = "Policy to allow access to IAM for main infra"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    # permissions with IAM
                    "iam:CreateRole",
                    "iam:DeleteRole",
                    "iam:GetRole",
                    "iam:ListRoles",
                    "iam:AttachRolePolicy",
                    "iam:DetachRolePolicy",
                    "iam:PassRole"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}
resource "aws_iam_role_policy_attachment" "github_oidc_role_iam_policy_attachment" {
    role       = aws_iam_role.github_main_infra_role.name
    policy_arn = aws_iam_policy.github_oidc_role_iam_policy.arn
}

# EC2 permissions (needed for building EKS)
resource "aws_iam_policy" "github_oidc_role_ec2_policy" {
    name = "github_main_infra_role_ec2_policies"
    description = "Policy to allow access to EC2 for main infra"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    # permissions with EC2
                    "ec2:DescribeInstances",
                    "ec2:DescribeKeyPairs",
                    "ec2:DescribeSecurityGroups",
                    "ec2:DescribeSubnets",
                    "ec2:DescribeVpcs",
                    "ec2:CreateSecurityGroup",
                    "ec2:DeleteSecurityGroup",
                    "ec2:AuthorizeSecurityGroupIngress",
                    "ec2:RevokeSecurityGroupIngress",
                    "ec2:AuthorizeSecurityGroupEgress",
                    "ec2:RevokeSecurityGroupEgress"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}
resource "aws_iam_role_policy_attachment" "github_oidc_role_iam_policy_attachment" {
    role       = aws_iam_role.github_main_infra_role.name
    policy_arn = aws_iam_policy.github_oidc_role_iam_policy.arn
}

# VPC permissions
resource "aws_iam_policy" "github_oidc_role_vpc_policy" {
    name = "github_main_infra_role_vpc_policies"
    description = "Policy to allow access to VPC for main infra"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    # permissions with VPC
                    
                    "ec2:CreateVpc",
                    "ec2:DeleteVpc",
                    "ec2:ModifyVpcAttribute",
                    "ec2:DescribeVpcs",
                    
                    "ec2:CreateSubnet",
                    "ec2:DeleteSubnet",
                    "ec2:ModifySubnetAttribute",
                    
                    "ec2:CreateInternetGateway",
                    "ec2:DeleteInternetGateway",
                    "ec2:AttachInternetGateway",
                    "ec2:DetachInternetGateway",
                    
                    "ec2:CreateRouteTable",
                    "ec2:DeleteRouteTable",
                    "ec2:CreateRoute",
                    "ec2:DeleteRoute",
                    "ec2:AssociateRouteTable",
                    "ec2:DisassociateRouteTable",
                    
                    "ec2:CreateNatGateway",
                    "ec2:DeleteNatGateway",
                    "ec2:DescribeNatGateways",
                    
                    "ec2:AllocateAddress", 
                    "ec2:ReleaseAddress"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}
resource "aws_iam_role_policy_attachment" "github_oidc_role_vpc_policy_attachment" {
    role       = aws_iam_role.github_main_infra_role.name
    policy_arn = aws_iam_policy.github_oidc_role_vpc_policy.arn
}

# ECR permissions
resource "aws_iam_policy" "github_oidc_role_ecr_policy" {
    name = "github_main_infra_role_ecr_policies"
    description = "Policy to allow access to ECR for main infra"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    # permissions with ECR
                    
                    # Ciclo de vida do Repositório ECR em si
                    "ecr:CreateRepository",
                    "ecr:DeleteRepository",
                    "ecr:DescribeRepositories",
                    "ecr:PutLifecyclePolicy",   
                    "ecr:DeleteLifecyclePolicy",
                    
                    "ecr:ListImages",
                    "ecr:DescribeImages",
                    "ecr:BatchDeleteImage",
                    
                    "ecr:GetAuthorizationToken", 
                    "ecr:InitiateLayerUpload",
                    "ecr:UploadLayerPart",
                    "ecr:CompleteLayerUpload",
                    "ecr:PutImage",
                    "ecr:BatchCheckLayerAvailability"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}
resource "aws_iam_role_policy_attachment" "github_oidc_role_ecr_policy_attachment" {
    role       = aws_iam_role.github_main_infra_role.name
    policy_arn = aws_iam_policy.github_oidc_role_ecr_policy.arn
}