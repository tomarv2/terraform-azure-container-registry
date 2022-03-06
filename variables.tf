variable "teamid" {
  description = "Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled. Defaults to false."
  default     = false
  type        = bool
}

variable "sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium. Classic (which was previously Basic) is supported only for existing resources."
  default     = "Standard"
  type        = string
}

variable "deploy_acr" {
  description = "Feature flag, true or false"
  default     = true
  type        = bool
}

variable "deploy_image" {
  description = "Feature flag, true or false"
  default     = true
  type        = bool
}

variable "dockerfile_folder" {
  description = "This is the folder which contains the Dockerfile"
  type        = string
}

variable "registry_name" {
  description = "Registry name"
  default     = null
  type        = string
}

variable "image_name" {
  description = "Image name"
  default     = null
  type        = string
}

variable "docker_image_tag" {
  type        = string
  description = "This is the tag which will be used for the image that you created"
  default     = "latest"
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

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}
variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  type        = string
  default     = "westus2"
}
