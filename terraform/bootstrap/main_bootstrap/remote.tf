data "terraform_remote_state" "microbootstrap" {
    backend = "local"

    config = {
        path = "${path.root}/../microbootstrap/terraform.tfstate"
    }
}