resource "aws_iam_role" "bootstrap_role" {
    name = "terraform-bootstrap-role"
    assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json

}

resource "aws_iam_role" "iamlive_role" {
    name = "iamlive-role"
    assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

# attaching policies to terraform-bootstrap-role

# Adding tempo administrator policy

# attaching policies to terraform-bootstrap-role

# Adding read only policy
resource "aws_iam_role_policy_attachment" "readonly_policy_attachment" {
    role = aws_iam_role.iamlive_role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}