data "terraform_remote_state" "microbootstrap" {
    backend = "local"

    config = {
        path = "${path.module}/../microbootstrap/terraform.tfstate"
    }
}