# Terraform

<!--ts-->

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
