
# IAM Roles

resource "aws_iam_role" "bootstrap_role" {
  name               = "terraform-bootstrap-role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

resource "aws_iam_role" "iamlive_role" {
  name               = "iamlive-role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}



# Policy Attachments - iamlive-role (debugger)

# Read-only policy for the iamlive debugger role
resource "aws_iam_role_policy_attachment" "readonly_policy_attachment" {
  role       = aws_iam_role.iamlive_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "_policy_attachment" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
