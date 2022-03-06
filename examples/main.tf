<<<<<<< HEAD
terraform {
  required_version = ">= 1.0.1"
  required_providers {
    azurerm = {
      version = "~> 2.98"
    }
  }
}

provider "azurerm" {
  features {}
}
module "acr" {
  source = "../"

  resource_group_name = "demo-resource_group"
  # DOCKER BUILD
  deploy_image      = true
  # Path to script directory relative to current location
  dockerfile_folder = "../scripts"
  location          = var.location
=======
module "acr" {
  source = "../"

  rg_name = "test-rg"
  # DOCKER BUILD
  deploy_image      = true
  dockerfile_folder = "/scripts"
>>>>>>> 31e0ceeb7a3465e9b1567032ec2d4bb7467b4b98
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
