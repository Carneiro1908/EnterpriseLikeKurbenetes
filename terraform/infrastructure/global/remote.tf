data "terraform_remote_state"  "origin" {
    backend = "local"

    config = {
        path = "../../bootstrap/terraform.tfstate"
    }
}