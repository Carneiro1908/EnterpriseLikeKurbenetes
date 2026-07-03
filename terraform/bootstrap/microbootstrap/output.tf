
# OICD output

output "github_oicd_policy_json" {
    value = data.aws_iam_policy_document.github_oidc_assume_role.json
}