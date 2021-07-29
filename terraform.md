# Terraform

<!--ts-->
* [Terraform](terraform.md#terraform)
   * [Terraform file](terraform.md#terraform-file)
   * [provider block](terraform.md#provider-block)
   * [resource block](terraform.md#resource-block)
   * [Terraform commands](terraform.md#terraform-commands)
      * [init](terraform.md#init)
      * [plan](terraform.md#plan)
      * [apply](terraform.md#apply)
      * [destroy](terraform.md#destroy)

<!-- Added by: runner, at: Thu Jul 29 11:16:50 UTC 2021 -->

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
