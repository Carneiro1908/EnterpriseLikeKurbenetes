# attaching administrator acsses for the roles temporaly

resource "aws_iam_role_policy_attachment" "dev_env_cicd_role_attachment" {
    role = aws_iam_role.dev_env_cicd_role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
} 

resource "aws_iam_role_policy_attachment" "staging_env_cicd_role_attachment" {
    role = aws_iam_role.staging_env_cicd_role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "prod_env_cicd_role_attachment" {
    role = aws_iam_role.prod_env_cicd_role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}