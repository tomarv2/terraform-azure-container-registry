locals {
  unique_registry_name     = var.registry_name != null ? var.registry_name : "${var.teamid}${var.prjid}${local.suffix}"
  georeplication_locations = var.sku == "Premium" ? var.georeplication_locations : null
}

resource "azurerm_container_registry" "registry" {
  count = var.deploy_acr ? 1 : 0

  name                     = local.unique_registry_name
  resource_group_name      = var.rg_name
  location                 = var.acr_location
  sku                      = var.sku
  georeplication_locations = local.georeplication_locations
  tags                     = merge(local.shared_tags)
  admin_enabled            = var.admin_enabled

}