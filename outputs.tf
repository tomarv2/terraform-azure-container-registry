output "registry_url" {
  value = join("", azurerm_container_registry.registry.*.login_server)
  #sensitive = true
}

output "registry_user" {
  value = join("", azurerm_container_registry.registry.*.admin_username)
  #sensitive = true
}

output "registry_pass" {
  value = join("", azurerm_container_registry.registry.*.admin_password)
  #sensitive = true
}

output "registry_id" {
  value = join("", azurerm_container_registry.registry.*.id)
}

output "registry_configure" {
  value = <<CONFIGURE
Authenticate to the Container registry by running the following command:
$ docker login \
  -u $(terraform output registry_user) \
  -p $(terraform output registry_pass) \
  $(terraform output registry_url)
CONFIGURE
}