<p align="center">
    <a href="https://github.com/tomarv2/terraform-azure-container-registry/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-azure-container-registry/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-azure-container-registry" /></a>
    <a href="https://github.com/tomarv2/terraform-azure-container-registry/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-azure-container-registry" /></a>
    <a href="https://github.com/tomarv2/terraform-azure-container-registry/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-azure-container-registry" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://twitter.com/intent/follow?screen_name=tomar_v2" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/tomar_v2?style=social&logo=twitter"></a>
</p>

## Terraform module for [Azure Container Registry](https://registry.terraform.io/modules/tomarv2/container-registry/azure/latest)

> :arrow_right:  Terraform module for [AWS Container Registry](https://registry.terraform.io/modules/tomarv2/ecr/aws/latest)

> :arrow_right:  Coming up Terraform module for [Google Artifact Registry](https://cloud.google.com/artifact-registry/docs/quickstarts)

### Versions

- Module tested for Terraform 1.0.1.
- Azure provider version [3.21.1](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-azure-container-registry/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-azure-container-registry" /></a> in your releases)

### Usage

#### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project'
terraform apply -var='teamid=tryme' -var='prjid=project'
terraform destroy -var='teamid=tryme' -var='prjid=project'
```
**Note:** With this option please take care of remote state storage

#### Option 2:

#### Recommended method (stores remote state in storage using `prjid` and `teamid` to create directory structure):

- Create python 3.8+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote --upgrade
```

- Set below environment variables:
```
export TF_AZURE_STORAGE_ACCOUNT=tfstatexxxxx # Output of remote_state.sh
export TF_AZURE_CONTAINER=tfstate # Output of remote_state.sh
export ARM_ACCESS_KEY=xxxxxxxxxx # Output of remote_state.sh
```

- Updated `examples` directory to required values

- Run and verify the output before deploying:
```
tf -c=azure plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -c=azure apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -c=azure destroy -var='teamid=foo' -var='prjid=bar'
```
**Note:** Read more on [tfremote](https://github.com/tomarv2/tfremote)
#### ACR
```
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
  deploy_image = true
  # Path to script directory relative to current location
  dockerfile_folder = "../scripts"
  location          = var.location
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
```

#### ACR with Push webhook
```
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
  deploy_image = true
  # Path to script directory relative to current location
  dockerfile_folder = "../scripts"
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
```

Please refer to examples directory [link](examples) for references.

### References
- https://docs.microsoft.com/en-us/azure/container-registry/container-registry-webhook
- https://github.com/onnimonni/terraform-ecr-docker-build-module

### Note
Ensure there are executable permissions on `scripts/build.sh`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.21.1 |
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.2.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.21.1 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.2.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_container_registry_webhook.webhooks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry_webhook) | resource |
| [null_resource.build_and_push](https://registry.terraform.io/providers/hashicorp/null/3.1.0/docs/resources/resource) | resource |
| [random_string.naming](https://registry.terraform.io/providers/hashicorp/random/3.1.0/docs/resources/string) | resource |
| [external_external.build_folder](https://registry.terraform.io/providers/hashicorp/external/2.2.0/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | Specifies whether the admin user is enabled | `bool` | `false` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of CIDRs to allow on the registry | `list(string)` | `[]` | no |
| <a name="input_allowed_subnets"></a> [allowed\_subnets](#input\_allowed\_subnets) | List of VNet/Subnet IDs to allow on the registry | `list(string)` | `[]` | no |
| <a name="input_azure_services_bypass_allowed"></a> [azure\_services\_bypass\_allowed](#input\_azure\_services\_bypass\_allowed) | Whether to allow trusted Azure services to access a network restricted Container Registry | `bool` | `false` | no |
| <a name="input_deploy_acr"></a> [deploy\_acr](#input\_deploy\_acr) | Feature flag, true or false | `bool` | `true` | no |
| <a name="input_deploy_image"></a> [deploy\_image](#input\_deploy\_image) | Feature flag, true or false | `bool` | `true` | no |
| <a name="input_docker_image_tag"></a> [docker\_image\_tag](#input\_docker\_image\_tag) | This is the tag which will be used for the image that you created | `string` | `"latest"` | no |
| <a name="input_dockerfile_folder"></a> [dockerfile\_folder](#input\_dockerfile\_folder) | This is the folder which contains the Dockerfile | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Additional tags to associate | `map(string)` | `{}` | no |
| <a name="input_georeplication"></a> [georeplication](#input\_georeplication) | A list of Azure locations where the container registry should be geo-replicated. Only activated on Premium SKU.<br>  Supported properties are:<br>    location                = string<br>    zone\_redundancy\_enabled = bool<br>    tags                    = map(string)<br>  or this can be a list of `string` (each element is a location) | `list(any)` | `[]` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Image name | `string` | `null` | no |
| <a name="input_images_retention_days"></a> [images\_retention\_days](#input\_images\_retention\_days) | Specifies the number of images retention days. | `number` | `90` | no |
| <a name="input_images_retention_enabled"></a> [images\_retention\_enabled](#input\_images\_retention\_enabled) | Specifies whether images retention is enabled (Premium only). | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region to use | `string` | n/a | yes |
| <a name="input_registry_name"></a> [registry\_name](#input\_registry\_name) | Registry name | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Name of the resource group | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the container registry. Possible values are Basic, Standard and Premium. Classic (which was previously Basic) is supported only for existing resources | `string` | `"Standard"` | no |
| <a name="input_trust_policy_enabled"></a> [trust\_policy\_enabled](#input\_trust\_policy\_enabled) | Specifies whether the trust policy is enabled (Premium only). | `bool` | `false` | no |
| <a name="input_webhooks"></a> [webhooks](#input\_webhooks) | A list of objects describing the webhooks resources required | <pre>list(object({<br>    name           = string<br>    service_uri    = string<br>    status         = string<br>    scope          = string<br>    actions        = list(string)<br>    custom_headers = map(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_registry_configure"></a> [registry\_configure](#output\_registry\_configure) | Registry configure |
| <a name="output_registry_id"></a> [registry\_id](#output\_registry\_id) | The Container Registry ID |
| <a name="output_registry_password"></a> [registry\_password](#output\_registry\_password) | The Password associated with the Container Registry Admin account - if the admin account is enabled |
| <a name="output_registry_url"></a> [registry\_url](#output\_registry\_url) | The URL that can be used to log into the container registry |
| <a name="output_registry_username"></a> [registry\_username](#output\_registry\_username) | The Username associated with the Container Registry Admin account - if the admin account is enabled |
<!-- END_TF_DOCS -->
