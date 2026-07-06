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
resource "aws_iam_policy" "admin_policy" {
    name = "terraform-bootstrap-admin-policy"
    description = "Policy to allow access to all resources for bootstrap"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "*"
                ]
                Effect   = "Allow"
                Resource = ["*"]
            }
        ]
    })
}
resource "aws_iam_role_policy_attachment" "admin_policy_attachment" {
    role       = aws_iam_role.bootstrap_role.name
    policy_arn = aws_iam_policy.admin_policy.arn
}

# attaching policies to terraform-bootstrap-role

# Adding read only policy
resource "aws_iam_policy" "readonly_policy" {
    name = "terraform-iamlive-readonly-policy"
    description = "Policy to allow iamlive read all resources and data from project to detect the policies needed"

    policy = jsondecode({
        "Version": "2012-10-17",
        "Statement": [
            {
            "Sid": "AllowReadAll",
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        },
        {
            "Sid": "BlockAnyModification",
            "Effect": "Deny",
            "Action": [
                "*:Create*",
                "*:Update*",
                "*:Delete*",
                "*:Put*",
                "*:Tag*",
                "*:Untag*",
                "*:Modify*",
                "*:Remove*",
                "*:Change*",
                "*:Attach*",
                "*:Detach*",
                "*:Associate*",
                "*:Disassociate*"
            ],
            "Resource": "*"
        }
        ]
    })   
}

resource "aws_iam_role_policy_attachment" "admin_policy_attachment" {
    role = aws_iam_role.iamlive_role
    policy_arn = aws_iam_policy.readonly_policy.arn
}