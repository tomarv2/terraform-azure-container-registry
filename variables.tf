variable "teamid" {
  description = "Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
}

variable "prjid" {
  description = "Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
}


variable "acr_location" {
  default = "westus"
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled. Defaults to false."
  default     = false
}

variable "sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium. Classic (which was previously Basic) is supported only for existing resources."
  default     = "Standard"
}

variable "georeplication_locations" {
  description = "A list of Azure locations where the container registry should be geo-replicated."
  type        = list(string)
  //  default     = null
  default = ["East US", "West Europe"]
}

variable "deploy_acr" {
  description = "feature flag, true or false"
  default     = true
  type        = bool
}

variable "deploy_image" {
  description = "feature flag, true or false"
  default     = true
  type        = bool
}

variable "dockerfile_folder" {
  type        = string
  description = "This is the folder which contains the Dockerfile"
}

variable "registry_name" {
  default = null
}

variable "image_name" {
  default = null
}

variable "docker_image_tag" {
  type        = string
  description = "This is the tag which will be used for the image that you created"
  default     = "latest"
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 3
}

locals {
  suffix = random_string.naming.result
}

variable "webhooks" {
  description = "A list of objects describing the webhooks resources required."
  type = list(object({
    name           = string
    service_uri    = string
    status         = string
    scope          = string
    actions        = list(string)
    custom_headers = map(string)
  }))
  default = []
}

variable "admin_password" {
  description = "admin_password - The Password associated with the Container Registry Admin account - if the admin account is enabled."
  default     = null
}
