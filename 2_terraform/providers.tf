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
  client_id       = var.var_client_id
  client_secret   = var.var_client_secret
  tenant_id       = var.var_tenant_id
  subscription_id = var.var_subsc_id
  features {}
}