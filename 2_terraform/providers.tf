variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

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
  backend "azurerm" {
    resource_group_name  = "RG_TFSTATE"
    storage_account_name = "tfstate011150926041"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "BjcVJ/6IaSIBbxemV08o+V4CDdeEm5XUdFymLlcVAQXILTer3ZLp0hvMVN1jyn5DfRS7GBZd5bgo+AStzXW/Yw=="
  }
}

provider "azurerm" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  features {}
}