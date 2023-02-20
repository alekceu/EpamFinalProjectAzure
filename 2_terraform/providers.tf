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
  client_id       = "0bf2a8cd-f2b2-4be2-8ffc-36772de5a639"
  client_secret   = "gTi8Q~3i7RH--fJ3fgZNmI1ZAAck5YsG8d4SactZ"
  tenant_id       = "de82e085-b114-496d-b42f-221b3c9f84f2"
  subscription_id = "4ddbf480-32c8-4bd9-99fb-7cea419d8be2"
  features {}
}