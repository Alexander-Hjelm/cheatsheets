# Azure Pipelines
<!--ts-->
* [Azure Pipelines](azure-pipelines.md#azure-pipelines)
* [Demands](azure-pipelines.md#demands)
  * [Agent name](azure-pipelines.md#agent-name)
* [Variables](azure-pipelines.md#variables)
  * [Using variable groups](azure-pipelines.md#using-variable-groups)
  * [Useful environment variables](azure-pipelines.md#useful-environment-variables)
  * [Check if a variable is set (not null)](azure-pipelines.md#check-if-a-variable-is-set-not-null)
  * [Use variables in powershell script](azure-pipelines.md#use-variables-in-powershell-script)
* [Triggers](azure-pipelines.md#triggers)
  * [Trigger on push to another repo](azure-pipelines.md#trigger-on-push-to-another-repo)
* [Resources](azure-pipelines.md#resources)
  * [Clone a repo from the public github](azure-pipelines.md#clone-a-repo-from-the-public-github)
* [Parameters](azure-pipelines.md#parameters)
* [Stages/Jobs](azure-pipelines.md#stagesjobs)
  * [Run multiple jobs in parallel for a stage](azure-pipelines.md#run-multiple-jobs-in-parallel-for-a-stage)
  * [Conditional execution](azure-pipelines.md#conditional-execution)
* [Templates](azure-pipelines.md#templates)
  * [Invoke Template as Job with parameters](azure-pipelines.md#invoke-template-as-job-with-parameters)
  * [Invoke template as Step](azure-pipelines.md#invoke-template-as-step)
  * [Invoke template from another project](azure-pipelines.md#invoke-template-from-another-project)
* [Each](azure-pipelines.md#each)
  * [Use each to create a loop with indices](azure-pipelines.md#use-each-to-create-a-loop-with-indices)
* [Debug](azure-pipelines.md#debug)
* [Pass variables between tasks](azure-pipelines.md#pass-variables-between-tasks)
  * [write to env variable](azure-pipelines.md#write-to-env-variable)
  * [read from env variable](azure-pipelines.md#read-from-env-variable)
* [Certificates, code signing](azure-pipelines.md#certificates-code-signing)
  * [How to use certificates with Azure Key Vault](azure-pipelines.md#how-to-use-certificates-with-azure-key-vault)
  * [Pipeline code signing example script](azure-pipelines.md#pipeline-code-signing-example-script)
* [Run/Build numbers](azure-pipelines.md#runbuild-numbers)
  * [Powershell](azure-pipelines.md#powershell)
* [Windows Machine File Copy](azure-pipelines.md#windows-machine-file-copy)
  * [Troubleshooting](azure-pipelines.md#troubleshooting)
    * [Same files skipped](azure-pipelines.md#same-files-skipped)
* [Replace tokens, tokenize](azure-pipelines.md#replace-tokens-tokenize)
  * [Replace tokens using parameters](azure-pipelines.md#replace-tokens-using-parameters)
* [Visual Studio build](azure-pipelines.md#visual-studio-build)
  * [Publish artifact as a .zip or files](azure-pipelines.md#publish-artifact-as-a-zip-or-files)
* [git](azure-pipelines.md#git)
  * [Expose access token to a git command in powershell](azure-pipelines.md#expose-access-token-to-a-git-command-in-powershell)
* [Agent setup](azure-pipelines.md#agent-setup)
  * [Must not run as sudo](azure-pipelines.md#must-not-run-as-sudo)
* [Set up a nuget feed and push packages](azure-pipelines.md#set-up-a-nuget-feed-and-push-packages)
* [Replace tokens manually, without the Replace Tokens task](azure-pipelines.md#replace-tokens-manually-without-the-replace-tokens-task)
* [Troubleshooting](azure-pipelines.md#troubleshooting-1)
  * [SYSTEM_ACCESSTOKEN env var not set](azure-pipelines.md#system_accesstoken-env-var-not-set)
  * [The reference assemblies for .NETFramework,Version=v4.8 were not found](azure-pipelines.md#the-reference-assemblies-for-netframeworkversionv48-were-not-found)
  * [You do not have the appropriate permissions to manage test suites under this area path.](azure-pipelines.md#you-do-not-have-the-appropriate-permissions-to-manage-test-suites-under-this-area-path)
  * [The Git repository with name or identifier XXX does not exist or you do not have permissions for the operation you are attempting.](azure-pipelines.md#the-git-repository-with-name-or-identifier-xxx-does-not-exist-or-you-do-not-have-permissions-for-the-operation-you-are-attempting)
  * [command not found](azure-pipelines.md#command-not-found)
  * [Connection string is replace by $(ReplacableToken...)" in web.config](azure-pipelines.md#connection-string-is-replace-by-replacabletoken-in-webconfig)
  * ["ERR:unable to get local issuer certificate" for NuGet tools installer](azure-pipelines.md#errunable-to-get-local-issuer-certificate-for-nuget-tools-installer)
  * [Error MSB3249: Application Configuration file "App.config" is invalid. ".", hexadecimal value 0x00, is an invalid character. Line 2, position 1.](azure-pipelines.md#error-msb3249-application-configuration-file-appconfig-is-invalid--hexadecimal-value-0x00-is-an-invalid-character-line-2-position-1)

<!-- Added by: runner, at: Mon Feb 14 07:33:11 UTC 2022 -->

<!--te-->

# Demands

## Agent name

```yaml
pool:
  name: [agent pool name]
  demands:
  - agent.name -equals morpheus
  - agent.computername -equals W1000A
```

# Variables

## Using variable groups

```yaml
variables:
- group: 8080222017_DAT_Test_Automation
- name: NugetVersion
  value: 5.9.1
```

## Useful environment variables

* **System.Debug**: Verbose logging.
* **System.DefaultWorkingDirectory**: The local path on the agent where your source code files are downloaded. For example: c:\agent_work\1\s
* **Agent.BuildDirectory**: The local path on the agent where all folders for a given build pipeline are created. This variable has the same value as Pipeline.Workspace. For example: /home/vsts/work/1
* **Build.ArtifactStagingDirectory**: The local path on the agent where any artifacts are copied to before being pushed to their destination.

More: <https://docs.microsoft.com/en-us/azure/devops/pipelines/build/variables?view=azure-devops&tabs=yaml>

## Check if a variable is set (not null)

```yaml
  - task: PowerShell@2
    displayName: "Check for access tokens"
    inputs:
      targetType: 'inline'
      script: |
        Write-Error "Source access token is not defined. Please define the secret runtime variable PATsource"
    condition: eq(variables['PATsource'], '')
```

Does not work for secret variables!

## Use variables in powershell script

```yaml
variables:
- template: variables.yml

#...

- task: PowerShell@2
      displayName: 'Replace tokens in CommonConfig.ts'
      inputs:
        targetType: 'inline'
        script: |
          ls
          Write-Host '$(variables.extensionId)-dev'
```

## Conditional variables

```yaml
variables:
  - name: azureSubscription
    ${{ if eq(parameters.subscription, 'lab') }}: 
      value: "azure-it-icc-lab-azdo-spn"
    ${{ if eq(parameters.subscription, 'dev') }}: 
      value: "azure-it-icc-development-azdo-spn"
    ${{ if eq(parameters.subscription, 'test') }}: 
      value: "azure-it-icc-test-azdo-spn"
    ${{ if eq(parameters.subscription, 'prod') }}: 
      value: "azure-it-icc-production-azdo-spn"
```

# Triggers

```yaml
# No trigger
trigger: none

# Branch filter
trigger: 
  branches:
    include: 
    - releases/*
    exclude:
    - releases/old*

# Tag filter
    trigger:
      tags:        # This filter is used for triggering the pipeline run
      - Production # Tags are AND'ed
      - Signed
```

## Trigger on push to another repo

Create a new CI pipeline for the other repo, then use this trigger in the first pipeline:

```yaml
resources:
  pipelines:
  - pipeline: wiki-ci   # Name of the pipeline resource
    source: confluence-migration-poc # Name of the pipeline referenced by the pipeline resource
    trigger: 
      branches:
      - master
```

# Resources

## Clone a repo from the public github

```yaml
resources:
  repositories:
    - repository: azure-devops-migration-tools # The name used to reference this repository in the checkout step
      type: github
      endpoint: Peter-Brymer
      name: nkdAgility/azure-devops-migration-tools
```

## Clone a repo from an AzDO project

```yaml
resources:
  repositories:
    - repository: sync-hub # The name used to reference this repository in the checkout step
      type: git
      name: Internal/sync-hub
      ref: master
```

## checkout a repo with a given branch

```yaml
  - checkout: git://$(System.TeamProject)/${{parameters.otherRepoName}}@refs/heads/${{parameters.otherRepoBranch}}
```

## Use parameters/variables inside resource blocks

```yaml
parameters:
- name: delfiBranch
  displayName: (Backend) - branch att deploya
  type: string
  default: 'develop'
- name: delfiFrontendBranch
  displayName: (Frontend) - branch att deploya
  type: string
  default: 'develop'
 
variables:
- name: branchNameBackend
  value: ${{ parameters.delfiBranch }}
- name: branchNameFrontend
  value: ${{ parameters.delfiFrontendBranch }}
 
resources:
  repositories:
  - repository: delfi
    type: githubenterprise
    endpoint: "GitHub Enterprise Server - ZA_JenkinsKFM"
    name: delfi/delfi
    ref: $(branchNameBackend)
  - repository: delfifrontend
    type: githubenterprise
    endpoint: "GitHub Enterprise Server - ZA_JenkinsKFM"
    name: delfi/delfifrontend
    ref: $(branchNameFrontend)
```

# Parameters

```yaml
parameters:
- name: stageTest
  displayName: Deploy to Test
  type: boolean
  default: true
```

Remember to reference parameters with double curly braces:

`'${{parameters.stageTest}}'`

# Stages/Jobs

## Run multiple jobs in parallel for a stage

```yaml
stages:
- stage: StageA
  displayName: 'Stage A'
  condition: succeeded()
  jobs:
  - job: 'Job A'
    pool:
      name: POOLNAME
      demands: msbuild
    steps:
    - template: /.azure-pipelines/templates/jobA.yml
  - job: 'Job B'
    pool:
      name: POOLNAME
      demands: msbuild
    steps:
    - template: /.azure-pipelines/templates/jobB.yml
```

## Conditional execution

```yaml
- ${{ if eq(parameters.stageTest, true) }}: 
  - stage: DeployTest
    displayName: 'Deploy Test'
    condition: succeeded()
    jobs:
    - template: /.azure-pipelines/templates/deploy-test.yml
```

```yaml
- task: CopyFiles@2
  inputs:
    SourceFolder: '$(Build.ArtifactStagingDirectory)/adapters'
    Contents: '**'
    TargetFolder: '$(Build.ArtifactStagingDirectory)/api/adapters'
  condition: and(succeeded(), ne(variables['Build.Reason'], 'PullRequest'))
```

### Use runtime variables and parameters in task conditions

```yaml
steps:
  - task: PowerShell@2
    inputs:
      targetType: 'inline'
      script: |
        Write-Output("##vso[task.setvariable variable=myvar;]"blablabla") `
        Write-Output("##vso[task.setvariable variable=myparam;]${{parameters.myparam}})

  - script: echo '$(myparam)'

  - task: PowerShell@2
    condition: and( eq(variables.myvar,'blablabla'), eq(variables.myparam, 'lablablab') )
    inputs:
      targetType: 'inline'
      script: |
        Write-Host "$(newAddressSpace) rocks"

# Deployments
```yaml
trigger: none

jobs:
  - deployment: 
#    variables:
#      - group: ${{parameters.extensionId}}-${{parameters.environment}}
#    pool:
#      vmImage: 'ubuntu-latest'
    environment:
      name: synchub-demo
      resourceName: synchub-demo
    strategy:
      runOnce:
        deploy:
          steps:
          - script: echo Hello, world!
            displayName: 'Run a one-line script'
```

# Templates

## Invoke Template as Job with parameters

```yaml
  - stage: DeployTest
    displayName: 'Deploy Test'
    condition: succeeded()
    jobs:
    - template: /.azure-pipelines/templates/deploy-test.yml
      parameters:
        environment: 'test'
        variablegroup: 'Test'
```

## Invoke template as Step

```yaml
jobs:
- job: 'Build'
  pool:
    name: PUPLUS
    demands: msbuild
  steps:
  - template: /.azure-pipelines/templates/build.yml
```

## Invoke template from another project

Child yaml file (the pipeline):

```yaml
resources: 
  repositories: 
  - repository: Common 
    name: Common 
    type: git 
    ref: main

extends:
  template: parent.yml@Common
```

Parent template (parent.yml in project Common):

```yaml
steps:
- task: PowerShell@2
  displayName: 'Install tfx'
  ...
```

# Each

Each is used to create loops. Can be used for setting up stages, jobs, tasks dynamically

main.yml:

```yaml
trigger:
- main

pool:
  vmImage: ubuntu-latest

extends:
  template: template.yml
  parameters:
      param: ["AA", "BB", "CC"]
```

template.yml:

```yaml
parameters:
  - name: param
    type: object
    default: []

stages:
  - ${{ each p in parameters.param }}:
    - stage: '${{ p }}'
      displayName: 'Stage ${{ p }}'
      jobs:
      - job: 'JobA'
        steps:
        - script: 'echo AAA'
```

## Use each to create a loop with indices

Store the indices array as a parameter on the template

```yaml
parameters:
- name: truthArray
  type: object
  default: [true, true, false]
- name: arrayB
  type: object
  default: ['a', 'b', 'c']
- name: loopIndices
  type: object
  default: [0, 1, 2]

# Deploy to each environment, one stage for each
- ${{ each i in parameters.loopIndices }}:
  - ${{ if eq(parameters.truthArray[i], true) }}: 
    - stage: ${{parameters.arrayB[i]}}
      displayName: 'Stage ${{parameters.arrayB[i]}}'
      condition: succeeded()
      jobs:
      ...
```

## Loop over complex objects

Pipeline:

```yaml
steps:
- template: /build.yml
  parameters:
    CopyFileOperations:
      - Op:
        Source: 'Ärende\WebAPI\bin\Release'
        Target: 'Ärende'
      - Op:
        Source: 'Rutt\WebAPI\bin\Release'
        Target: 'Rutt'
      - Op:
        Source: 'Resurs\WebAPI\bin\Release'
        Target: 'Resurs'
      - Op:
        Source: 'Test\WebAPI\bin\Release'
        Target: 'Test'
```

Template:

```yaml
parameters:
- name: CopyFileOperations
  type: object
  default: []

- ${{ each op in parameters.CopyFileOperations}}:
  - task: CopyFiles@2
    inputs:
      SourceFolder: '${{op.Source}}'
      TargetFolder: '${{op.Target}}'
```

# Debug

Can only be done by setting the system.debug variable in yaml:

```yaml
variables:
- name: System.Debug
  value: true
```

# Pass variables between tasks

## write to env variable

```bat
$varToBeWritten = "Test"
Write-Host "##vso[task.setvariable variable=varToBeWritten]$varToBeWritten"
```

## read from env variable

```bat
Write-Host $env:varToBeWritten
```

# Start/Stop windows service

Make sure the agent user has sufficent access

```yml
- task: PowerShell@2
  displayName: "Stop service"
  inputs:
    targetType: 'inline'
    script: |
      Get-Service -DisplayName TopDeskIntegration | Stop-Service
  continueOnError: true

- task: CopyFiles@2
  inputs:
    SourceFolder: 'azuredevops\integration.service\bin\Release'
    Contents: '**'
    TargetFolder: 'C:\TopDeskIntegration'
    OverWrite: true

- task: PowerShell@2
  displayName: "Start service"
  inputs:
    targetType: 'inline'
    script: |
      Get-Service -DisplayName TopDeskIntegration | Start-Service
```

# Certificates, code signing

## How to use certificates with Azure Key Vault

[Link](https://www.dotnetcurry.com/devops/1507/azure-key-vault-secrets-pipelines)

## Pipeline code signing example script

```yaml
pool:
  vmImage: windows-2019

steps:
- script: dotnet publish -o $(Build.ArtifactStagingDirectory)
  displayName: 'dotnet publish'
- task: AzureKeyVault@1
  inputs:
    azureSubscription: 'twelve21-signdotnetcore-connection'
    keyVaultName: 'twelve21-key-vault'
- powershell: |
    $filePath = '$(Build.ArtifactStagingDirectory)\Twelve21.SignDotNetCore.dll';
    $base64 = '$(twelve21-sample-certificate)';
    $buffer = [System.Convert]::FromBase64String($base64);
    $certificate = [System.Security.Cryptography.X509Certificates.X509Certificate2]::new($buffer);
    Set-AuthenticodeSignature -FilePath $filePath -Certificate $certificate;
- task: PublishBuildArtifacts@1
  inputs:
    pathtoPublish: '$(Build.ArtifactStagingDirectory)'
    artifactName: build
```

# nuget/npm with upstream sources and root certificate

## nuget

```yml
variables:
  NODE_EXTRA_CA_CERTS: 'D:\certs\root.pem'

...

  - task: NuGetToolInstaller@1

  - task: NuGetCommand@2
    inputs:
      command: 'restore'
      restoreSolution: 'aaa/$(solution)'
      feedsToUse: 'config'
      nugetConfigPath: 'aaa/nuget.config'
```

Example `nuget.config:`

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
	<packageSources>
		<add key="Optimizely" value="https://nuget.optimizely.com/feed/packages.svc/" />
		<add key="NuGet" value="https://api.nuget.org/v3/index.json" />
		<add key="LocalPackages" value=".\LocalPackages" />
	</packageSources>
</configuration>
```

### Push nuget package

```yml
    # .NET Publish
    - task: PowerShell@2
      displayName: '.NET Publish: $(slnName)'
      inputs:
        targetType: 'inline'
        script: |
          dotnet publish $(solution) --configuration $(BuildConfiguration) /p:PublishProfile=FolderProfile$(PublishProfile)
      env:
        HTTP_PROXY: $(clientProxy)
        NO_PROXY: $(noProxy)
        NODE_TLS_REJECT_UNAUTHORIZED: 0

    - task: NuGetCommand@2
      displayName: 'NuGet pack'
      condition: eq('${{ parameters.NugetRelease }}', 'true')
      inputs:
        command: 'pack'
        packagesToPack: '$(DelgivningsresultatWorkingDir)\$(NuspecFile)'
        versioningScheme: 'byBuildNumber'

    - task: NuGetCommand@2
      displayName: 'NuGet push'
      condition: eq('${{ parameters.NugetRelease }}', 'true')
      inputs:
        command: 'push'
        packagesToPush: '$(Build.ArtifactStagingDirectory)/**/*.nupkg;!$(Build.ArtifactStagingDirectory)/**/*.symbols.nupkg'
        nuGetFeedType: 'external'
        publishFeedCredentials: 'KFM Nexus (Nuget)'
```

## npm

In order to install packages from a public source like **npmjs**, you must use a `customFeed` that has `https://registry.npmjs.org/` as an upstream:

```yml
variables:
  NODE_EXTRA_CA_CERTS: 'D:\certs\root.pem'

...

  - task: NodeTool@0
    inputs:
      versionSpec: '12.16.3'

  - task: Npm@1
    inputs:
      command: 'install'
      workingDir: 'aaa/aaa'
      verbose: true
      customRegistry: 'useFeed'
      customFeed: '44046838-d275-4c84-b3a6-aaaaaaaaaaaa'
```

### nx affected

**.azure-pipelines.yml**:

```yaml
- task: PowerShell@2
  displayName: 'npm testAffected'
  inputs:
    targetType: 'inline'
    script: |
      $sourceBranch = "$(System.PullRequest.SourceBranch)"
      $targetBranch = "$(System.PullRequest.TargetBranch)"
      git checkout $targetBranch
      git checkout $sourceBranch
      npm run testAffected -- --base=$targetBranch --head=$sourceBranch
  condition: and(succeeded(), eq(variables['Build.Reason'], 'PullRequest'))
```

**package.json**:

```json
"testAffected": "node ./node_modules/@nrwl/cli/bin/nx.js affected --target=test --parallel=5 --code-coverage --watch=false"
```

# Run/Build numbers

[Link](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/run-number?view=azure-devops&tabs=yaml)

## Powershell

```bat
$env:BUILD_BUILDNUMBER
```

# Windows Machine File Copy

Uses robocopy, argument list: [Link](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy)

## Troubleshooting

### Same files skipped

By default, Robocopy skips copying existing files if the specific metadata (file size, timestamp, file name) of the files match.
Override this with the `\IS` (Include same) argument.

# Replace tokens, tokenize

## Replace tokens using parameters

```yaml
- task: PowerShell@2
  inputs:
    targetType: 'inline'
    script: |
      Write-Host "##vso[task.setvariable variable=accessTokenSource]${{parameters.accessTokenSource}}"
      Write-Host "##vso[task.setvariable variable=accessTokenTarget]${{parameters.accessTokenTarget}}"
- task: replacetokens@4
  inputs:
    rootDirectory: './DevOps-as-a-Service-Migration-configs/'
    targetFiles: '${{parameters.configfilepath}}'
    encoding: 'auto'
    tokenPattern: 'default'
    writeBOM: true
    actionOnMissing: 'warn'
    keepToken: false
    actionOnNoFiles: 'continue'
    enableTransforms: false
    useLegacyPattern: false
    enableTelemetry: true
```

# Visual Studio build

## Publish artifact as a .zip or files

```bat
/p:PackageAsSingleFiles=true (zip)
/p:PackageAsSingleFiles=false (files)
```

# git

## Expose access token to a git command in powershell

```powershell
Function Git-Command {
    Param(
        [string]$Command
    )
    $Token = $env:SYSTEM_ACCESSTOKEN
    if (!($Token)) {
        Invoke-Expression -Command "git $Command"
    }
    else {
        Invoke-Expression -Command "git -c http.extraheader=""Authorization: bearer $Token"" $Command"
    }
}

Git-Command "checkout $defaultBranch"
Git-Command "push $upstreamName '*:*'"
Git-Command "push --tags $upstreamName"
```

# Agent setup

## Must not run as sudo

do:

```bash
export AGENT_ALLOW_RUNASROOT="1"
```

# Set up a nuget feed and push packages

To be used if the customer needs to build a package, but the TFS server does not have access to the public NuGet registry.

Create a new NuGet feed

Add it to the NuGet.config (in the same folder as the .sln):

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <clear />
    <add key="LocalPackages" value="packages" />
    <add key="TopDeskIntegration" value="https://tfs.dd.dll.se/DefaultCollection/Microsoft_BI/_packaging/TopDeskIntegration/nuget/v3/index.json" />
  </packageSources>
</configuration>
```

Then do the following to push:

```pwsh
dotnet nuget push --source "TopDeskIntegration" --api-key az .\packages\Newtonsoft.Json.10.0.3\Newtonsoft.Json.10.0.3.nupkg
```

To push all packages in one folder:

```pwsh
dotnet nuget push --source "TopDeskIntegration_Packages" --api-key az .\packages\**\*.nupkg
```

In the build pipeline:

```yaml
- task: NuGetInstaller@0
  diaplayName: 'NuGet restore azuredevop/projectname"
  inputs:
    solution: 'solution.sln'
    nugetConfigPath: 'nuget.config'
    restoreMode: 'restore'
    nugetVersion: '4.0.0.2283'

- task: VSBuild@1
  inputs:
    solution: 'solution.sln'
    vsVersion: '15.0'
    configuration: 'Release'
    msbuildArchitecture: 'x64'
```

# Replace tokens manually, without the Replace Tokens task

Put this file in .azure-pipelines: <https://gist.github.com/niclaslindstedt/8425dbc5db81b779f3f46659f7232f91>

the pipeline:

```yaml
- task: PowerShell@2
  displayName: "Replace tokens in app.config"
  inputs:
    targetType: 'inline*
    script: |
      . .\.azure-pipelines\replace-tokens.ps1
      Replace-Tokens -InputFile app.Release.config -OutputFile app.config -Tokens @(tokenA="$(tokenA)"; tokenB="$(tokenB)";} -StartTokenPattern "{{" -EndTokenPattern "}}"
```

## Specific pipeline examples

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

### Deploy an azure web app

```yaml
variables:
  buildConfiguration: 'Release'

steps:

- script: dotnet build --configuration $(buildConfiguration)
  displayName: 'dotnet build $(buildConfiguration)'

- task: DotNetCoreCLI@2
  inputs:
    command: 'publish'
    publishWebProjects: true

- task: AzureWebApp@1
  inputs:
    azureSubscription: 'Visual Studio Enterprise Subscription – MPN(1)(90964ca6-bc75-4398-9fa2-75c890c373cf)'
    appType: 'webApp'
    appName: 'alexanderdemo'
    package: '$(System.DefaultWorkingDirectory)/**/*.zip'
    deploymentMethod: 'auto'
```

### Upload a file to an Azure Blob Storage

Requirements:

- Azure Storage Account
- Configure access for the service account: storage account -> Access Control (IAM) -> add your service principal used in the service connection as a Storage Blob Data Contributor role

```yaml
steps:
    - task: ArchiveFiles@2
      displayName: 'Archive atlassian-migration-suite'
      inputs:
        rootFolderOrFile: '$(Build.ArtifactStagingDirectory)'
        includeRootFolder: false
        archiveType: 'zip'
        archiveFile: '$(Build.ArtifactStagingDirectory)/atlassian-migration-suite-$(Build.BuildId).zip'
        replaceExistingArchive: true
      condition: and(succeeded(), ne(variables['Build.Reason'], 'PullRequest'))

    - task: PublishPipelineArtifact@1
      inputs:
        targetPath: '$(Build.ArtifactStagingDirectory)/atlassian-migration-suite-$(Build.BuildId).zip'
        artifact: 'drop'
        publishLocation: 'pipeline'

    - task: AzureFileCopy@5
      inputs:
        SourcePath: '$(Build.ArtifactStagingDirectory)/atlassian-migration-suite-$(Build.BuildId).zip'
        azureSubscription: 'Visual Studio Enterprise Subscription – MPN(1)(90964ca6-bc75-4398-9fa2-75c890c373cf)'
        Destination: 'AzureBlob'
        storage: 'jmpsa'
        ContainerName: 'atlassian-migration-suite'
        CleanTargetBeforeCopy: true
      continueOnError: true
```

# Troubleshooting

## SYSTEM_ACCESSTOKEN env var not set

Under the release, go to Agent job and check **Allow scripts to access the OAuth toke** to true.

For yaml builds, set the AccessToken variable like this:

```yaml
variables:
  system_accesstoken: $(System.AccessToken)
```

## The reference assemblies for .NETFramework,Version=v4.8 were not found

Install the specified dotnet core + targeting pack on the build machine.

## You do not have the appropriate permissions to manage test suites under this area path

Under Project Settings -> Boards -> Porject Configuration -> Areas. Select **Security** for the top-level area and ensure that the Build Service user has the **Manage Test Plans** and **Manage Test Suites** permissions.

## The Git repository with name or identifier XXX does not exist or you do not have permissions for the operation you are attempting

Check the Collection/Project Settings: Pipelines -> Settings. Try and disable the "Limit job authorization scope" flags.

## command not found

* Run the `env.sh`-script on the agent.
* stop/start the service as your current user (`sudo ./svc.sh myuser`)

## Connection string is replace by $(ReplacableToken...)" in web.config

Add `/p:AutoParameterizationWebConfigConnectionStrings=false` in the MSBuild arguments

## "ERR:unable to get local issuer certificate" for NuGet tools installer

Try to set the NODE.EXTRA.CA.CERTS variable to the path of the certificate (e.g. C:\opt\node-extra-ca-certs\dll-certs.cer)

If that does not work, install the nuget CLI on the build machine and use that.

## Error MSB3249: Application Configuration file "App.config" is invalid. ".", hexadecimal value 0x00, is an invalid character. Line 2, position 1

File is in UTF16 encoding when it should be in UTF16.

Powershell:

```pwsh
XXX | Out-File -FilePath $InputFile -Encoding UTF8
```
