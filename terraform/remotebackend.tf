data "terraform_remote_state" "infra" {
  backend = "azurerm"
  config = {
    resource_group_name  = "GithubActions-Trainning-Tf-Dev"
    storage_account_name = "tfbackend024356d"
    container_name       = "tf-backend"
    key                  = "common.tfstate"
  }
}