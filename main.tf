locals {
  unique_registry_name = var.registry_name != null ? var.registry_name : "${var.teamid}${var.prjid}${local.suffix}"
}

resource "azurerm_container_registry" "registry" {
  count = var.deploy_acr ? 1 : 0

  name                = local.unique_registry_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  tags                = merge(local.shared_tags)
  admin_enabled       = var.admin_enabled

}
