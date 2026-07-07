resource "aws_iam_role" "envs_role" {
    name = "envs_role"
    assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

# Attaching policies to the role 

resource "aws_iam_role_policy_attachment" "envs_role_policy_attachment" {
    role = aws_iam_role.envs_role.name
    policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}