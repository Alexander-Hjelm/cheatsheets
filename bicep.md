# bicep

## Conditional deployments

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

## Deploy a bicep file in an azure pipeline

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
