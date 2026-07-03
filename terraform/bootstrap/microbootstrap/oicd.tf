# Getting an TLS certificated from provider
data "tls_certificate" "oidc" {
    url = "https://token.action.githubusercontent.com"
}

# Create the provider OICD in IAM
resource "aws_iam_openid_connect_provider" "oidc" {
    url = data.tls_certificate.oidc.url
    client_id_list = ["sts.amazonaws.com"]
    thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
}

# Create the trust policy
data "aws_iam_policy_document" "github_oidc_assume_role" {
    id = "github_oidc_assume_role_policy_${locals.account_id}"

    statement {
        actions = ["sts:AssumeRoleWithWebIdentity"]
        effect = "Allow"

        principals {
            type = "Federated"
            identifiers = [aws_iam_openid_connect_provider.oidc.arn]
        }

        condition {
            test = "StringEquals"
            variable = "token.actions.githubusercontent.com:aud"
            values = ["sts.amazonaws.com"]
        }

        condition {
            test = "StringLike"
            variable = "token.actions.githubusercontent.com:sub"
            values = ["repo:Carneiro1908/EnterpriseLikeKurbenetes:*"]
        }
    }
}