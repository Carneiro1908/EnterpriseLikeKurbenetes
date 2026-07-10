provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}

resource "kubernetes_namespace" "monitoring" {
  count = var.enable_monitoring ? 1 : 0
  metadata {
    name = "monitoring"
  }
}

data "aws_iam_policy_document" "grafana_cloudwatch_read" {
  count = var.enable_monitoring ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetInsightRuleReport",
      "cloudwatch:GetMetricStatistics",
      "logs:DescribeLogGroups",
      "logs:GetLogGroupFields",
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:GetQueryResults",
      "logs:GetLogEvents",
      "ec2:DescribeTags",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
      "tag:GetResources"
    ]
    resources = ["*"]
  }
}

module "grafana_irsa_role" {
  count   = var.enable_monitoring ? 1 : 0
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.44"

  role_name = "${var.cluster_name}-grafana-cloudwatch-role"

  role_policy_arns = {
    cloudwatch_read = aws_iam_policy.grafana_cloudwatch_read[0].arn
  }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["monitoring:grafana"]
    }
  }

  tags = var.tags
}

resource "aws_iam_policy" "grafana_cloudwatch_read" {
  count  = var.enable_monitoring ? 1 : 0
  name   = "${var.cluster_name}-grafana-cloudwatch-read"
  policy = data.aws_iam_policy_document.grafana_cloudwatch_read[0].json
}

resource "helm_release" "grafana" {
  count      = var.enable_monitoring ? 1 : 0
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "8.6.4"
  namespace  = kubernetes_namespace.monitoring[0].metadata[0].name
  timeout    = 300

  values = [
    yamlencode({
      resources = {
        requests = { cpu = "50m", memory = "96Mi" }
        limits   = { cpu = "150m", memory = "192Mi" }
      }

      persistence = {
        enabled = false   
      }

      adminPassword = var.grafana_admin_password

      serviceAccount = {
        create = true
        name   = "grafana"
        annotations = {
          "eks.amazonaws.com/role-arn" = module.grafana_irsa_role[0].iam_role_arn
        }
      }

      service = {
        type = "ClusterIP"   
      }

      datasources = {
        "datasources.yaml" = {
          apiVersion = 1
          datasources = [{
            name      = "CloudWatch"
            type      = "cloudwatch"
            access    = "proxy"
            isDefault = true
            jsonData = {
              defaultRegion = "eu-central-1"
              authType      = "default"
            }
          }]
        }
      }
    })
  ]

  depends_on = [
    module.eks,
    module.grafana_irsa_role
  ]
}