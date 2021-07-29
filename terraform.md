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

<!-- Added by: runner, at: Thu Jul 29 11:09:37 UTC 2021 -->

<!--te-->

## Terraform file

Default name: **main.tf**

## provider block

```hcl
provider "azurerm" {
    version = "2.5.0"
    features {}
}
```

## resource block

resource <type> <id>

```hcl
resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "Norway East"
}
```

## Terraform commands

### init

### plan
  
### apply
