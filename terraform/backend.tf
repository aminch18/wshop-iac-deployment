terraform {
  backend "azurerm" {
    resource_group_name  = "GithubActions-Trainning-Tf-Dev"
    storage_account_name = "tfbackend024356d"
    container_name       = "tf-backend"
    key                  = "application.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}