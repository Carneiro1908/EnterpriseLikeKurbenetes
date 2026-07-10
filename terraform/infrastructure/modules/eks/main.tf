# 1. THE EKS CLUSTER
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = length(var.public_subnet_ids) > 0 ? var.public_subnet_ids : var.private_subnet_ids

  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = var.endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.endpoint_public_access_cidrs

  cluster_enabled_log_types = var.cluster_log_types

  cluster_encryption_config = var.enable_cluster_encryption ? {
    resources = ["secrets"]
  } : {}

  enable_irsa = var.enable_irsa

  # Base addons that do not require IAM roles or do not cause dependency cycles
  cluster_addons = {
    vpc-cni    = { most_recent = true }
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
  }

  eks_managed_node_groups = var.node_groups

  tags = merge(var.tags, {
    ManagedBy = "terraform"
  })
}

# 2. IAM ROLES FOR ADDONS (IRSA)

# IAM Role for EBS CSI Driver
module "ebs_csi_irsa_role" {
  count   = var.enable_irsa ? 1 : 0
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.44"

  role_name = "${var.cluster_name}-ebs-csi-role"

  role_policy_arns = {
    policy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = var.tags
}

# IAM Role for CloudWatch Observability
module "cloudwatch_observability_irsa_role" {
  count   = var.enable_observability ? 1 : 0
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.44"

  role_name = "${var.cluster_name}-cloudwatch-observability-role"

  role_policy_arns = {
    policy = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["amazon-cloudwatch:cloudwatch-agent"]
    }
  }

  tags = var.tags
}

# 3. INDEPENDENT EKS ADDONS

# EBS CSI Driver Addon
resource "aws_eks_addon" "aws_ebs_csi_driver" {
  count = var.enable_irsa ? 1 : 0

  cluster_name = module.eks.cluster_name
  addon_name   = "aws-ebs-csi-driver"

  resolve_conflicts_on_create = "OVERWRITE"
  service_account_role_arn    = module.ebs_csi_irsa_role[0].iam_role_arn
}

# CloudWatch Observability Addon
resource "aws_eks_addon" "cloudwatch_observability" {
  count = var.enable_observability ? 1 : 0

  cluster_name = module.eks.cluster_name
  addon_name   = "amazon-cloudwatch-observability"

  resolve_conflicts_on_create = "OVERWRITE"
  service_account_role_arn    = module.cloudwatch_observability_irsa_role[0].iam_role_arn
}