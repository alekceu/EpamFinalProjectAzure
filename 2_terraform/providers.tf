terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  client_id       = ${env.ARM_CLIENT_ID}
  client_secret   = ${env.ARM_CLIENT_SECRET}
  tenant_id       = ${env.ARM_TENANT_ID}
  subscription_id = ${env.ARM_SUBSCRIPTION_ID}
  features {}
}