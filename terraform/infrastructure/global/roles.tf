# Creating roles for environments
resource "aws_iam_role" "dev_env_cicd_role" {
    name = "dev-cicd-environment-role"
    assume_role_policy = data.terraform_remote_state.bootstrap_oicd_trust_policy_json
}

resource "aws_iam_role" "staging_env_cicd_role" {
    name = "staging-cicd-environment-role"
    assume_role_policy = data.terraform_remote_state.bootstrap_oicd_trust_policy_json
}

resource "aws_iam_role" "prod_env_cicd_role" {
    name = "prod-cicd-environment-role"
    assume_role_policy = data.terraform_remote_state.bootstrap_oicd_trust_policy_json
}