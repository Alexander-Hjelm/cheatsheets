# Azure CLI
<!--ts-->
* [Azure CLI](az.md#azure-cli)
* [Azure DevOps](az.md#azure-devops)
   * [Login, log in](az.md#login-log-in)
   * [Run pipeline](az.md#run-pipeline)
   * [Create release from release definition](az.md#create-release-from-release-definition)

<!-- Added by: runner, at: Sun Oct 17 16:14:55 UTC 2021 -->

<!--te-->

# Azure

## Login, Log in
```bash
az login    # Interactive
az login -u <username> -p <password>
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
