output "registry_url" {
  description = "Registry Url"
  value       = join("", azurerm_container_registry.registry.*.login_server)
  #sensitive = true
}

output "registry_user" {
  description = "Registry user"
  value       = join("", azurerm_container_registry.registry.*.admin_username)
  #sensitive = true
}

output "registry_pass" {
  description = "Registry password"
  value       = nonsensitive(join("", azurerm_container_registry.registry.*.admin_password))
}

output "registry_id" {
  description = "Registry Id"
  value       = join("", azurerm_container_registry.registry.*.id)
}

output "registry_configure" {
  description = "Registry configure"
  value       = <<CONFIGURE
Authenticate to the Container registry by running the following command:
$ docker login \
  -u $(terraform output registry_user) \
  -p $(terraform output registry_pass) \
  $(terraform output registry_url)
CONFIGURE
}
