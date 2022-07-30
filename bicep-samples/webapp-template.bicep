// Deploy an Azure web app with it's own App Service Plan (hosting plan)

@description('Application common name.')
param commonName string

@description('Location of the resources')
param location string = resourceGroup().location

@description('Location prefix')
@allowed([
  'weu'
])
param locationPrefix string = 'weu'

@description('Environment identifier')
@allowed([
  'lab'
  'dev'
  'test'
  'prod'
])
param environment string = 'lab'

@description('Application Service Plan name. If unspecified, the application will deploy in a new ASP.')
param appServicePlanName string = ''

@description('Application Service Resource Group name. If unspecified, the ASP will deploy in the same RG as the application.')
param appServicePlanResourceGroup string= ''

param alwaysOn bool = false

@description('Size of the App Service Plan. Allowed values "Shared", "Standard" and "WorkflowStandard"')
@allowed([
  'Shared'
  'Standard'
  'WorkflowStandard'
])
param sku string = 'Shared'

@description('SKU Code of the App Service Plan.')
param skuCode string = 'B1'

@description('Number of Workers for App Service Plan. Default: 1')
param numberOfWorkers int = 1

@description('Tech stack. Default: "dotnet"')
param currentStack string = 'dotnet'

@description('.NET Framework version. Default: "v5.0"')
param netFrameworkVersion string = 'v5.0'

var subscriptionId = subscription().subscriptionId
var resourceGroupName = '${environment}-${locationPrefix}-${commonName}-rg'
var hostingPlanResourceGroupName = (appServicePlanResourceGroup == '') ? resourceGroupName : appServicePlanResourceGroup
var webAppName = '${environment}-${locationPrefix}-${commonName}-webapp'
var hostingPlanName = (appServicePlanName == '') ? '${environment}-${locationPrefix}-${commonName}-webapp-sp' : appServicePlanName
var appInsightsName = '${environment}-${locationPrefix}-${commonName}-appinsight'

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

// Deploy the App Service Plan (application-specific)
resource hostingPlan 'Microsoft.Web/serverfarms@2021-02-01' = if (appServicePlanName == '') {
  name: hostingPlanName
  location: location
  kind: ''
  tags: {}
  properties: {
    zoneRedundant: false
    targetWorkerCount: numberOfWorkers
  }
  sku: {
    tier: sku
    name: skuCode
  }
  dependsOn: []
}

resource appInsights 'microsoft.insights/components@2020-02-02-preview' = {
  name: appInsightsName
  location: location
  tags: {}
  kind: 'web'
  properties: {
    ApplicationId: webAppName
    Application_Type: 'web'
    IngestionMode: 'ApplicationInsights'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}
