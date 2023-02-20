variable "var_client_id" {}
variable "var_client_secret" {}
variable "var_tenant_id" {}
variable "var_subsc_id" {}

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
  client_id       = ${ARM_CLIENT_ID}
  client_secret   = ${ARM_CLIENT_SECRET}
  tenant_id       = ${ARM_TENANT_ID}
  subscription_id = ${ARM_SUBSCRIPTION_ID}
  features {}
}