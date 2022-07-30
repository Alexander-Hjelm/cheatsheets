param appServiceName string
param networkSecurityGroupId string
param vnet_name string
param subnet_address_space string

// set the target scope for this file
targetScope = 'resourceGroup'

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: vnet_name
}

resource applicationSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet
  name: '${appServiceName}-sn'
  properties: {
    addressPrefix: '${subnet_address_space}/25'
    networkSecurityGroup: {
      id: networkSecurityGroupId
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
