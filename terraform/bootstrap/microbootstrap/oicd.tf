# Fetch the TLS certificate data from GitHub's OIDC endpoint
data "tls_certificate" "oidc" {
  url = "https://token.actions.githubusercontent.com"
}

# Create the OpenID Connect (OIDC) provider in AWS IAM
resource "aws_iam_openid_connect_provider" "oidc" {
  url            = data.tls_certificate.oidc.url
  client_id_list = ["sts.amazonaws.com"]
  
  thumbprint_list = data.tls_certificate.oidc.certificates[*].sha1_fingerprint
}

# Define the IAM Trust Policy Document for GitHub Actions
data "aws_iam_policy_document" "github_oidc_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    # Restrict the trusted principal to the OIDC provider created above
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.oidc.arn]
    }

    # Condition: Ensure the audience matches the official AWS STS client ID
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # Condition: Scopes down permissions to your specific repository and any branch/workflow
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:Carneiro1908/EnterpriseLikeKurbenetes:*"]
    }

    # Condition: Extra layer of security ensuring only your GitHub handle can trigger the role
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:actor"
      values   = ["Carneiro1908"]
    }
  }
}