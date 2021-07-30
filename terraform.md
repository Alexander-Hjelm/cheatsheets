# Terraform

<!--ts-->
* [Terraform](terraform.md#terraform)
   * [Terraform file](terraform.md#terraform-file)
      * [provider block](terraform.md#provider-block)
      * [resource group](terraform.md#resource-group)
      * [Container instance](terraform.md#container-instance)
      * [Varialbes](terraform.md#varialbes)
   * [Terraform commands](terraform.md#terraform-commands)
      * [init](terraform.md#init)
      * [plan](terraform.md#plan)
      * [apply](terraform.md#apply)
      * [destroy](terraform.md#destroy)
      * [Azure pipelines provision stage](terraform.md#azure-pipelines-provision-stage)

<!-- Added by: runner, at: Fri Jul 30 08:37:58 UTC 2021 -->

<!--te-->

## Terraform file

Default name: **main.tf**

### provider block

```hcl
provider "azurerm" {
    version = "2.5.0"
    features {}
}
```

### resource group

resource <type> <id>

```hcl
resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "Norway East"
}
```

### Container instance
```hcl
resource "azurerm_container_group" "tfcg_test" {
  name = "weatherapirg"
  location = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name
  ip_address_type = "public"
  dns_name_label = "alexanderhjelmweatherapi"
  os_type = "linux"

  container {
    name = "weatherapi"
    image = "alexanderhjelm/weatherapi"
    cpu = "1"
    memory = "1"
    ports {
        port = 80
        protocol = "TCP"
    }
  }
}
```

### Varialbes
```hcl
variable "imagebuild" {
  type = string
  default = ""
  description = "Latest image build"
}
```

Reference as:
```hcl
${var.imagebuild}
```

## Terraform commands

### init
```bash
terraform init
```

### plan
```bash
terraform plan
```
  
### apply
```bash
  az login
terraform apply
```

### destroy
```bash
terraform destroy
```

### Azure pipelines provision stage
```yaml
- stage: Provision
displayName: 'Terraforming on Azure...'
dependsOn: Build
jobs:
- job: Provision
  displayName: 'Provisioning Container Instance'
  pool:
    vmImage: 'ubuntu-latest'
  variables: 
  - group: TerraformEnvVars
  steps:
  - script: |
      set -e
      terraform init -input=false
      terraform apply -input=false -auto-approve
    name: 'RunTerraform'
    displayName: 'Run Terraform'
    env:
      ARM_CLIENT_ID: $(ARM_CLIENT_ID)
      ARM_CLIENT_SECRET: $(ARM_CLIENT_SECRET)
      ARM_TENANT_ID: $(ARM_TENANT_ID)
      ARM_SUBSCRIPTION_ID: $(ARM_SUBSCRIPTION_ID)
      TF_VAR_imagebuild: $(tag)
  
```
