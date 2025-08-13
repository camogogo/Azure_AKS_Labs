terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

provider "azurerm" {
  features {}
}

# Use the Azure CLI login that your workflow sets up (azure/login@v2)
# and explicitly avoid MSI (which is what fails in GitHub Actions).
provider "azapi" {
  use_cli = true
  use_msi = false
  # (Optional) be explicit about context
  subscription_id = data.azurerm_client_config.current.subscription_id
  tenant_id       = data.azurerm_client_config.current.tenant_id
}

data "azurerm_client_config" "current" {}
