data "terraform_remote_state" "bootstrap_oicd_trust_policy_json" {
    backend = "local"

    config = {
        path = "../../bootstrap/terraform.tfstate"
    }
}