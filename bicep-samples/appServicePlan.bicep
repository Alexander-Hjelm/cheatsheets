// Deploy an AppSerivcePlan, NSG and subnet in an existing VNet

param name string

@description('Location of the resources')
param location string = resourceGroup().location

@description('Size of the App Service Plan. Allowed values "Standard" and "WorkflowStandard"')
@allowed([
  'Standard'
  'WorkflowStandard'
])
param sku string

@description('Number of Workers for App Service Plan."')
param numberOfWorkers int = 1

@description('SKU Code of the App Service Plan. Allowed values S1, S2 and WS1')
@allowed([
  'S1'
  'S2'
  'WS1'
])
param skucode string

@description('Platform. Allowed values "windows" or "linux"')
@allowed([
  'windows'
  'linux'
])
param platform string

@description('Environment identifier')
@allowed([
  'lab'
  'dev'
  'test'
  'prod'
])
param environment string = 'lab'

@description('Template identifier')
@allowed([
  'reliability'
  'performance'
  'logicapp'
])
param template string = 'reliability'

@description('Location prefix')
@allowed([
  'weu'
])
param locationPrefix string = 'weu'

@description('Id of Log Analytics workspace.')
param logAnalytics_WorkspaceId string = ''

@description('Name of the existing vnet where we should create the application subnet')
param vnet_name string = ''

@description('Name of the Resource Group where the existing vnet is located')
param vnet_rg_name_suffix string = 'core-rg'

@description('The address space of the subnet')
param subnet_address_space string = '10.0.0.0'

var appServiceName = (template != 'logicapp') ? '${environment}-${locationPrefix}-${template}-${platform}-${name}' : '${environment}-${locationPrefix}-${template}-${name}'
var kind = (platform == 'windows') ? 'app' : 'linux'
var vnet_rg_name = '${environment}-${locationPrefix}-${vnet_rg_name_suffix}'

resource rServerFarm 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServiceName
  location: location
  kind: kind
  properties: {
    zoneRedundant: false
    targetWorkerCount: numberOfWorkers
  }
  sku: {
    tier: sku
    name: skucode
  }
}

resource rDiagnosticsSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'la-diag-settings'
  location: location
  properties: {
    workspaceId: logAnalytics_WorkspaceId
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          enabled: true
          days: 90
        }
      }
    ]
  }
  scope: rServerFarm
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: '${environment}-${locationPrefix}-${template}-${platform}-plan01-nsg'
  location: location
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

// deploy to different scope
module subnet_deploy 'subnet.bicep' = {
  name: 'subnet_deploy'
  scope: resourceGroup(vnet_rg_name)
  params: {
    appServiceName: appServiceName
    networkSecurityGroupId: networkSecurityGroup.id
    vnet_name: vnet_name
    subnet_address_space: subnet_address_space
  }
  dependsOn: [
    networkSecurityGroup
  ]
}
