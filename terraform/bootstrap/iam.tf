resource "aws_iam_role" "infra_cicd_role" {
    name = "infrastructure-cicd-role"
    assume_role_policy = data.aws_iam_policy_document.github_actions_trust.json
}


# attaching policy
resource "aws_iam_role_policy_attachment" "infra_cicd_role_attachment" {
    role = aws_iam_role.infra_cicd_role.name  
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # Temporaly administrator
}
