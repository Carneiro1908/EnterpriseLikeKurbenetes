# IAM Role

resource "aws_iam_role" "github_main_infra_role" {
  name               = "github_main_infra_role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

resource "aws_iam_role_policy_attachment" "readonlaawwdy_policy_attachment" {
  role       = aws_iam_role.github_main_infra_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}