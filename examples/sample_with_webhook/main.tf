terraform {
  required_version = ">= 1.0.1"
  required_providers {
    azurerm = {
      version = "~> 3.21.1"
    }
  }
}

provider "azurerm" {
  features {}
}

module "acr" {
  source = "../../"

  resource_group = "demo-resource_group"
  # DOCKER BUILD
  deploy_image = true
  # Path to scripts directory relative to current location
  dockerfile_folder = "../../scripts"
  location          = var.location
  # WEBHOOK
  webhooks = [
    {
      name        = "mywebhook"
      service_uri = "https://mywebhookreceiver.example/mytag"
      status      = "enabled"
      scope       = "mytag:*"
      actions     = ["push"]
      custom_headers = {
        "Content-Type" = "application/json"
      }
    },
  ]
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
