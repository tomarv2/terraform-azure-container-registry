<p align="center">
    <a href="https://github.com/tomarv2/terraform-azure-container-registry/actions/workflows/security_scans.yml" alt="Security Scans">
        <img src="https://github.com/tomarv2/terraform-azure-container-registry/actions/workflows/security_scans.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-azure-container-registry" /></a>
    <a href="https://github.com/tomarv2/terraform-azure-container-registry/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-azure-container-registry" /></a>
    <a href="https://github.com/tomarv2/terraform-azure-container-registry/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-azure-container-registry" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://discord.gg/XH975bzN" alt="chat on Discord">
        <img src="https://img.shields.io/discord/813961944443912223?logo=discord"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

# Terraform module to create [Azure Container Registry](https://registry.terraform.io/modules/tomarv2/container-registry/azure/latest)

####

> :arrow_right:  Terraform module for [Google Container Registry](https://registry.terraform.io/modules/tomarv2/container-registry/google/latest)

> :arrow_right:  Terraform module for [AWS Container Registry](https://registry.terraform.io/modules/tomarv2/ecr/aws/latest)

## Versions

- Module tested for Terraform 0.14.
- Azure provider version [2.48.0](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-azure-container-registry/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-azure-container-registry" /></a> in your releases)

**NOTE:** 

- Read more on [tfremote](https://github.com/tomarv2/tfremote)

## Usage

Recommended method:

- Create python 3.6+ virtual environment 
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote
```

- Set below environment variables:
```
export TF_AZURE_STORAGE_ACCOUNT=tfstatexxxxx # Output of remote_state.sh
export TF_AZURE_CONTAINER=tfstate # Output of remote_state.sh
export ARM_ACCESS_KEY=xxxxxxxxxx # Output of remote_state.sh
```  

- Make required change to `examples` directory 

- Run and verify the output before deploying:
```
tf -cloud azure plan -var "subscription_id=<>" -var "client_id=<>" -var "client_secret=<>" -var "tenant_id=<>"
```

- Run below to deploy:
```
tf -cloud azure apply -var "subscription_id=<>" -var "client_id=<>" -var "client_secret=<>" -var "tenant_id=<>"
```

- Run below to destroy:
```
tf -cloud azure destroy -var "subscription_id=<>" -var "client_id=<>" -var "client_secret=<>" -var "tenant_id=<>"
```

> ❗️ **Important** - Two variables are required for using `tf` package:
>
> - teamid
> - prjid
>
> These variables are required to set backend path in the remote storage.
> Variables can be defined using:
>
> - As `inline variables` e.g.: `-var='teamid=demo-team' -var='prjid=demo-project'`
> - Inside `.tfvars` file e.g.: `-var-file=<tfvars file location> `
>
> For more information refer to [Terraform documentation](https://www.terraform.io/docs/language/values/variables.html)

##### ACR
```
module "acr" {
  source = "../"

  rg_name         = "test-rg"
  # DOCKER BUILD
  deploy_image      = true
  
  dockerfile_folder = "scripts"
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
```

##### ACR with Push webhook
```
module "acr" {
  source = "../"

  rg_name         = "test-rg"
  # DOCKER BUILD
  deploy_image      = true
  
  dockerfile_folder = "scripts"
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

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| azurerm | ~> 2.48 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.48 |
| external | n/a |
| null | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acr\_location | n/a | `string` | `"westus"` | no |
| admin\_enabled | Specifies whether the admin user is enabled. Defaults to false. | `bool` | `false` | no |
| admin\_password | admin\_password - The Password associated with the Container Registry Admin account - if the admin account is enabled. | `any` | `null` | no |
| client\_id | n/a | `any` | n/a | yes |
| client\_secret | n/a | `any` | n/a | yes |
| deploy\_acr | feature flag, true or false | `bool` | `true` | no |
| deploy\_image | feature flag, true or false | `bool` | `true` | no |
| docker\_image\_tag | This is the tag which will be used for the image that you created | `string` | `"latest"` | no |
| dockerfile\_folder | This is the folder which contains the Dockerfile | `string` | n/a | yes |
| georeplication\_locations | A list of Azure locations where the container registry should be geo-replicated. | `list(string)` | <pre>[<br>  "East US",<br>  "West Europe"<br>]</pre> | no |
| image\_name | n/a | `any` | `null` | no |
| prjid | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| registry\_name | n/a | `any` | `null` | no |
| rg\_name | n/a | `any` | n/a | yes |
| sku | The SKU name of the container registry. Possible values are Basic, Standard and Premium. Classic (which was previously Basic) is supported only for existing resources. | `string` | `"Standard"` | no |
| subscription\_id | n/a | `any` | n/a | yes |
| teamid | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| tenant\_id | n/a | `any` | n/a | yes |
| webhooks | (Required) A list of objects describing the webhooks resources required. | <pre>list(object({<br>    name           = string<br>    service_uri    = string<br>    status         = string<br>    scope          = string<br>    actions        = list(string)<br>    custom_headers = map(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| registry\_configure | n/a |
| registry\_id | n/a |
| registry\_pass | n/a |
| registry\_url | n/a |
| registry\_user | n/a |

### References
- https://docs.microsoft.com/en-us/azure/container-registry/container-registry-webhook
- https://github.com/onnimonni/terraform-ecr-docker-build-module

### Note
Ensure there are executable permissions on `scripts/build.sh`