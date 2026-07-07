# Create the trust policy
data "aws_iam_policy_document" "github_oidc_assume_role" {
    statement {
        actions = ["sts:AssumeRoleWithWebIdentity"]
        effect = "Allow"

        principals {
            type = "Federated"
            identifiers = ["arn:aws:iam::${local.account_id}:oidc-provider/token.actions.githubusercontent.com"]
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