# bicep

## Decompile ARM JSON to bicep

```ps1
az bicep decompile --file main.json
```

Or decompile with this online service: <https://bicepdemo.z22.web.core.windows.net/>

## Basic deployment of a Storage Account

```bicep
param location string = resourceGroup().location
param namePrefix string = 'storage'

var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'
var storageAccountSku = 'Standard_RAGRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSku
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountId string = storageAccount.id
```

## Bicep technicalities

### Conditional deployment

```bicep
@allowed([
  'new'
  'existing'
])
param newOrExisting string = 'new'

resource sa 'Microsoft.Storage/storageAccounts@2019-06-01' = if (newOrExisting == 'new') {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
```

### Modular deployment

main.bicep:

```bicep
module appService 'modules/appService.bicep' = {
  name: 'appService'
  scope: resourceGroup('my-rg-name')
  params: {
    location: location
    appServiceAppName: appServiceAppName
    environmentType: environmentType
  }
}
```

subnet.bicep:

```bicep
param location string
param appServiceAppName string

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'toy-product-launch-plan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverFarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
```

### Child resources

#### Nested resources

```bicep
resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmName
  location: location
  properties: {
    // ...
  }

  resource installCustomScriptExtension 'extensions' = {
    name: 'InstallCustomScript'
    location: location
    properties: {
      // ...
    }
  }
}
```

#### Parent property

```bicep
resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmName
  location: location
  properties: {
    // ...
  }
}

resource installCustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  parent: vm
  name: 'InstallCustomScript'
  location: location
  properties: {
    // ...
  }
}
```

### Depends on

```bicep
resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmName
  location: location
  properties: {
    // ...
  }
}

resource installCustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  name: '${vmName}/InstallCustomScript'
  dependsOn: [
    vm
  ]
  //...
}
```

### Existing resources

```bicep
resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: 'toy-design-vnet'
}
```

#### Existing child resources

```bicep
resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: 'toy-design-vnet'

  resource managementSubnet 'subnets' existing = {
    name: 'management'
  }
}
```

### Resources outside the resource group

```bicep
resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  scope: resourceGroup('networking-rg')
  name: 'toy-design-vnet'
}
```

### Loops

#### For each element in array

```bicep
param location string = resourceGroup().location
param storageNames array = [
  'contoso'
  'fabrikam'
  'coho'
]

resource storageAcct 'Microsoft.Storage/storageAccounts@2021-06-01' = [for name in storageNames: {
  name: '${name}${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}]
```

#### For each object in array

```bicep
param rgLocation string = resourceGroup().location

var subnets = [
  {
    name: 'api'
    subnetPrefix: '10.144.0.0/24'
  }
  {
    name: 'worker'
    subnetPrefix: '10.144.1.0/24'
  }
]

resource vnet 'Microsoft.Network/virtualNetworks@2020-07-01' = {
  name: 'vnet'
  location: rgLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.144.0.0/20'
      ]
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.subnetPrefix
      }
    }]
  }
}
```

#### Loop with condition

```bicep
param location string = resourceGroup().location
param storageCount int = 2
param createNewStorage bool = true

var baseName = 'store${uniqueString(resourceGroup().id)}'

module stgModule './storageAccount.bicep' = [for i in range(0, storageCount): if(createNewStorage) {
  name: '${i}deploy${baseName}'
  params: {
    storageName: '${i}${baseName}'
    location: location
  }
}]
```

### Deploying resources at different scopes

#### Management group

```bicep
targetScope = 'managementGroup'

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  // ...
}
```

#### Subscription

```bicep
targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'example-resource-group'
  location: 'westus'
}
```

## Using bicep deployments in Azure CLI

### Deployment command

```bicep
az deployment group create --template-file ./main.bicep --resource-group storage-resource-group
```

### Get output

```ps1
az deployment group show \
  -g <resource-group-name> \
  -n <deployment-name> \
  --query properties.outputs.resourceID.value
```

## Specific resource deployments

### App Service Plan

```bicep
@description('Size of the App Service Plan. Allowed values "Shared", "Standard" and "WorkflowStandard"')
@allowed([
  'Shared'
  'Standard'
  'WorkflowStandard'
])
param sku string = 'Shared'

@description('SKU Code of the App Service Plan.')
param skuCode string = 'B1'

resource hostingPlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'myrg-mywebapp-sp'
  location: 'weu'
  kind: ''
  tags: {}
  properties: {
    zoneRedundant: false
    targetWorkerCount: 1
  }
  sku: {
    tier: sku
    name: skuCode
  }
  dependsOn: []
}
```

### Application Insights

```bicep
resource appInsights 'microsoft.insights/components@2020-02-02-preview' = {
  name: 'appInsightsName'
  location: 'weu'
  tags: {}
  kind: 'web'
  properties: {
    ApplicationId: 'my-web-app'
    Application_Type: 'web'
    IngestionMode: 'ApplicationInsights'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}
```

### Databse account + database

```bicep
param cosmosDBAccountName string = 'toyrnd-${uniqueString(resourceGroup().id)}'
param cosmosDBDatabaseThroughput int = 400
param location string = resourceGroup().location

var cosmosDBDatabaseName = 'FlightTests'
var cosmosDBContainerName = 'FlightTests'
var cosmosDBContainerPartitionKey = '/droneId'

resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  name: cosmosDBAccountName
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
      }
    ]
  }
}

resource cosmosDBDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2020-04-01' = {
  parent: cosmosDBAccount
  name: cosmosDBDatabaseName
  properties: {
    resource: {
      id: cosmosDBDatabaseName
    }
    options: {
      throughput: cosmosDBDatabaseThroughput
    }
  }
}
```

### Network Security Group

```bicep
resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: 'mywebapp-nsg'
  location: 'weu'
  tags: {}
  properties: {}
}

resource networkSecurityGroup_Allow_HTTPS_Inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroup
  name: 'Allow_HTTPS_Inbound'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    access: 'Allow'
    priority: 1010
    direction: 'Inbound'
    sourceAddressPrefixes: [
      '193.45.95.20'
    ]
    destinationAddressPrefix: '*'
  }
}

resource networkSecurityGroup_Allow_HTTPS_Outbound 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroup
  name: 'Allow_HTTPS_Outbound'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    access: 'Allow'
    priority: 1010
    direction: 'Outbound'
    sourceAddressPrefixes: [
      '192.168.80.26'
      '192.168.76.76'
      '192.168.28.28'
    ]
    destinationAddressPrefix: '*'
  }
}
```

### Policy

```bicep
targetScope = 'subscription'

var policyDefinitionName = 'DenyFandGSeriesVMs'
var policyAssignmentName = 'DenyFandGSeriesVMs'

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2020-03-01' = {
  name: policyDefinitionName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    parameters: {}
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Compute/virtualMachines'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.Compute/virtualMachines/sku.name'
                like: 'Standard_F*'
              }
              {
                field: 'Microsoft.Compute/virtualMachines/sku.name'
                like: 'Standard_G*'
              }
            ]
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2020-03-01' = {
  name: policyAssignmentName
  properties: {
    policyDefinitionId: policyDefinition.id
  }
}
```

### Resource lock

```bicep
resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  name: cosmosDBAccountName
  location: location
  properties: {
    // ...
  }
}

resource lockResource 'Microsoft.Authorization/locks@2016-09-01' = {
  scope: cosmosDBAccount
  name: 'DontDelete'
  properties: {
    level: 'CanNotDelete'
    notes: 'Prevents deletion of the toy data Cosmos DB account.'
  }
}
```

### Storage account

```bicep
resource sa 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'myrg-mysstorageaccount-sa'
  location: 'weu'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
```

### Subnet

```bicep
resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: vnet_name
}

resource applicationSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet
  name: 'appServiceName-sn'
  properties: {
    addressPrefix: '10.0.0.0/24'
    networkSecurityGroup: {
      id: 'networkSecurityGroupId'
    }
    serviceEndpoints: [
      {
        service: 'Microsoft.Web'
      }
    ]
    delegations: [
      {
        name: 'delegation'
        properties: {
          serviceName: 'Microsoft.Web/serverFarms'
        }
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Disabled'
  }
}
```

### Web app

```bicep
resource webApp 'Microsoft.Web/sites@2018-11-01' = {
  name: webAppName
  location: location
  tags: {}
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    name: webAppName
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: reference('microsoft.insights/components/${appInsightsName}', '2015-05-01').InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: reference('microsoft.insights/components/${appInsightsName}', '2015-05-01').ConnectionString
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~2'
        }
        {
          name: 'XDT_MicrosoftApplicationInsights_Mode'
          value: 'default'
        }
        {
          name: 'WEBSITE_TIME_ZONE'
          value: 'W. Europe Standard Time'
        }
      ]
      virtualApplications: [
        {
          virtualPath: '/'
          physicalPath: 'site\\wwwroot'
          preloadEnabled: false
        }
        {
          virtualPath: '/api'
          physicalPath: 'site\\wwwroot\\api'
          preloadEnabled: false
        }
      ]
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: currentStack
        }
      ]
      phpVersion: 'OFF'
      netFrameworkVersion: netFrameworkVersion
      alwaysOn: alwaysOn
      ftpsState: 'FtpsOnly'
    }
    serverFarmId: '/subscriptions/${subscriptionId}/resourcegroups/${hostingPlanResourceGroupName}/providers/Microsoft.Web/serverfarms/${hostingPlanName}'
    clientAffinityEnabled: true
  }
  dependsOn: [
    appInsights
    hostingPlan
  ]
}
```

## Deploy a bicep file in a CI/CD workflow

### Deploy a bicep file in an azure pipeline

```yaml
parameters:
- name: bicepFile
  type: string
  default: ""
- name: azureSubscription
  type: string
  default: ""
- name: location
  type: string
  default: ""
- name: ResourceGroupName
  type: string
  default: ""
- name: vnet
  type: string
  default: ""

steps:
- task: AzureCLI@2
  displayName: 'AZ CLI, Build bicep file'
  inputs:
    azureSubscription: '${{parameters.azureSubscription}}'
    scriptType: 'ps'
    scriptLocation: 'inlineScript'
    inlineScript: 'az bicep build --file ${{parameters.bicepFile}}.bicep'

- task: PublishBuildArtifacts@1
  displayName: 'Publish artifact'
  inputs:
    PathtoPublish: '$(Build.SourcesDirectory)/${{parameters.bicepFile}}.json'
    ArtifactName: 'finishedTemplate'
    publishLocation: 'Container'

- task: AzureCLI@2
  displayName: 'Deploy ARM template'
  inputs:
    azureSubscription: '${{parameters.azureSubscription}}'
    scriptType: 'ps'
    scriptLocation: 'inlineScript'
    inlineScript: |
      az group create --name ${{parameters.ResourceGroupName}} --location ${{parameters.location}}
      az deployment group create  `
      --template-file $(Build.SourcesDirectory)/finishedTemplate/${{parameters.bicepFile}}.json `
      --parameters @$(Build.SourcesDirectory)\${{parameters.bicepFile}}.parameters.${{parameters.aspTemplate}}.json `
      --resource-group ${{parameters.ResourceGroupName}} `
      --parameters vnet_name=${{parameters.vnet}}
```

### Deploy a bicep file in a GitHub Action

```yaml
name: deploy-toy-website

on: [workflow_dispatch]

env:
    AZURE_RESOURCEGROUP_NAME: ToyWebsite
    ENVIRONMENT: nonprod

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}
    - uses: azure/arm-deploy@v1
      with:
        deploymentName: ${{ github.run_number }}
        resourceGroupName: ${{ env.AZURE_RESOURCEGROUP_NAME }}
        template: ./deploy/main.bicep
        parameters: environmentType=${{ env.ENVIRONMENT }}
```
