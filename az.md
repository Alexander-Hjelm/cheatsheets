# Azure CLI
<!--ts-->
* [Azure CLI](az.md#azure-cli)
* [Azure](az.md#azure)
   * [Login, Log in](az.md#login-log-in)
   * [Working with enumerated resources](az.md#working-with-enumerated-resources)
   * [Manage resource groups](az.md#manage-resource-groups)
      * [Create resource groups](az.md#create-resource-groups)
      * [List resource groups](az.md#list-resource-groups)
      * [Get information on a resource group](az.md#get-information-on-a-resource-group)
      * [Delete resource group](az.md#delete-resource-group)
   * [Manage VNets](az.md#manage-vnets)
   * [Manage VMs](az.md#manage-vms)
      * [Open port](az.md#open-port)
   * [Manage Subnets](az.md#manage-subnets)
   * [Manage Network Security Rules](az.md#manage-network-security-rules)
      * [Create Network Security Rule](az.md#create-network-security-rule)
      * [List Network Security Rules](az.md#list-network-security-rules)
* [Azure DevOps](az.md#azure-devops)
   * [Login, log in](az.md#login-log-in-1)
   * [Run pipeline](az.md#run-pipeline)
   * [Create release from release definition](az.md#create-release-from-release-definition)
* [Locations](az.md#locations)

<!-- Added by: runner, at: Tue Dec 14 13:46:37 UTC 2021 -->

<!--te-->

# Azure

## Login, Log in
```bash
az login    # Interactive
az login -u <username> -p <password>
```

## Working with enumerated resources
```bash
az vm open-port --ids $(az vm list -g MyResourceGroup --query "[].id" -o tsv) --port '*'
```

## Manage resource groups

### Create resource groups
```bash
az group create --name az-303-cli --location norwayeast --tags "course=az303"
```

### List resource groups
```bash
az group list
```

### Get information on a resource group
```bash
az group show --name <rg-name>
```

### Delete resource group
```bash
 az group delete --name az-303-cli
```

## Manage VNets
```bash
az network vnet create --name myVNet --resource-group CreateVNetQS-rg --subnet-name default --location norwauest --address-prefix 10.0.0.0/16
az network vnet list --resource-group az303-cli
az network vnet show --name VNET-linux --resource-group az303-cli
```

## Manage VMs
```bash
az vm create \
    --resource-group az303-cli \
    --name Linux-VM \
    --image UbuntuLTS \
    --public-ip-sku Standard \
    --public-ip-address linux-vm-pip \
    --admin-username azureuser \
    --admin-password password1A1A \
    --location norwayeast \
    --vnet-name VNET-linux \
    --size Standard_B1s
```

### Open port
```bash
az vm open-port --resource-group az303-cli --name Linux-VM --port 22
```

## Manage Subnets
```bash
az network vnet subnet create --address-prefixes 10.0.0.0/17 --name SNET-Linux-1 --resource-group az303-cli --vnet-name VNET-linux
az network vnet subnet show --name SNET-Linux-1 --resource-group az303-cli --vnet-name VNET-Linux
```

## Manage Network Security Rules

### Create Network Security Rule
```bash
az network nsg rule create --name SSH \
  --protocol Tcp \
  --nsg-name Linux-VMNSG \
  --priority 1000 \
  --direction Inbound \
  --resource-group az303-cli \
  --source-address-prefixes '*' \
  --source-port-range 0-65535 \
  --destination-address-prefixes '*' \
  --destination-port-range 0-65535 \
  --access Allow
```

### List Network Security Rules
```bash
az network nsg rule list --resource-group az303-cli --nsg-name Linux-VMNSG
```

# Azure DevOps

## Login, log in
Save your PAT in a file (pat.txt), then:
```bash
cat pat.txt | az devops login --organization https://dev.azure.com/alexanderhjelmsolidify
```

## Run pipeline
```bash
az pipelines run --name <pipeline name>
```
or
```bash
az pipelines run --id <pipeline id>
```

## Create release from release definition
```bash
az pipelines release create --definition-name="ImportTestResults Gherkin"
```

# Locations
```
az account list-locations -o table
```
```
DisplayName          Latitude    Longitude    Name
-------------------  ----------  -----------  ------------------
East Asia             22.267      114.188      eastasia
Southeast Asia        1.283       103.833      southeastasia
Central US            41.5908     -93.6208     centralus
East US               37.3719     -79.8164     eastus
East US 2             36.6681     -78.3889     eastus2
West US               37.783      -122.417     westus
North Central US      41.8819     -87.6278     northcentralus
South Central US      29.4167     -98.5        southcentralus
North Europe          53.3478     -6.2597      northeurope
West Europe           52.3667     4.9          westeurope
Japan West            34.6939     135.5022     japanwest
Japan East            35.68       139.77       japaneast
Brazil South          -23.55      -46.633      brazilsouth
Australia East        -33.86      151.2094     australiaeast
Australia Southeast   -37.8136    144.9631     australiasoutheast
South India           12.9822     80.1636      southindia
Central India         18.5822     73.9197      centralindia
West India            19.088      72.868       westindia
Jio India West        22.470701   70.05773     jioindiawest
Jio India Central     21.146633   79.08886     jioindiacentral
Canada Central        43.653      -79.383      canadacentral
Canada East           46.817      -71.217      canadaeast
UK South              50.941      -0.799       uksouth
UK West               53.427      -3.084       ukwest
West Central US       40.890      -110.234     westcentralus
West US 2             47.233      -119.852     westus2
Korea Central         37.5665     126.9780     koreacentral
Korea South           35.1796     129.0756     koreasouth
France Central        46.3772     2.3730       francecentral
France South          43.8345     2.1972       francesouth
Australia Central     -35.3075    149.1244     australiacentral
Australia Central 2   -35.3075    149.1244     australiacentral2
UAE Central           24.466667   54.366669    uaecentral
UAE North             25.266666   55.316666    uaenorth
South Africa North    -25.731340  28.218370    southafricanorth
South Africa West     -34.075691  18.843266    southafricawest
Switzerland North     47.451542   8.564572     switzerlandnorth
Switzerland West      46.204391   6.143158     switzerlandwest
Germany North         53.073635   8.806422     germanynorth
Germany West Central  50.110924   8.682127     germanywestcentral
Norway West           58.969975   5.733107     norwaywest
Norway East           59.913868   10.752245    norwayeast
Brazil Southeast      -22.90278   -43.2075     brazilsoutheast
West US 3             33.448376   -112.074036  westus3
```
