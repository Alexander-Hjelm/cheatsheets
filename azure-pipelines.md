# Azure Pipelines
<!--ts-->
* [Azure Pipelines](azure-pipelines.md#azure-pipelines)
* [Demands](azure-pipelines.md#demands)
   * [Agent name](azure-pipelines.md#agent-name)
* [Useful environment variables](azure-pipelines.md#useful-environment-variables)
* [Triggers](azure-pipelines.md#triggers)
   * [Trigger on push to another repo](azure-pipelines.md#trigger-on-push-to-another-repo)
* [Parameters](azure-pipelines.md#parameters)
* [Stages/Jobs](azure-pipelines.md#stagesjobs)
   * [Run multiple jobs in parallel for a stage](azure-pipelines.md#run-multiple-jobs-in-parallel-for-a-stage)
   * [Conditional execution](azure-pipelines.md#conditional-execution)
* [Templates](azure-pipelines.md#templates)
   * [Invoke Template as Job with parameters](azure-pipelines.md#invoke-template-as-job-with-parameters)
   * [Invoke template as Step](azure-pipelines.md#invoke-template-as-step)
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
* [Visual Studio build](azure-pipelines.md#visual-studio-build)
   * [Publish artifact as a .zip or files](azure-pipelines.md#publish-artifact-as-a-zip-or-files)
* [Troubleshooting](azure-pipelines.md#troubleshooting-1)
   * [SYSTEM_ACCESSTOKEN env var not set](azure-pipelines.md#system_accesstoken-env-var-not-set)
   * [The reference assemblies for .NETFramework,Version=v4.8 were not found](azure-pipelines.md#the-reference-assemblies-for-netframeworkversionv48-were-not-found)
   * [You do not have the appropriate permissions to manage test suites under this area path.](azure-pipelines.md#you-do-not-have-the-appropriate-permissions-to-manage-test-suites-under-this-area-path)

<!-- Added by: runner, at: Fri Aug 13 07:33:14 UTC 2021 -->

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

# Useful environment variables

- **System.Debug**: Verbose logging.
- **System.DefaultWorkingDirectory**: The local path on the agent where your source code files are downloaded. For example: c:\agent_work\1\s
- **Agent.BuildDirectory**: The local path on the agent where all folders for a given build pipeline are created. This variable has the same value as Pipeline.Workspace. For example: /home/vsts/work/1
- **Build.ArtifactStagingDirectory**: The local path on the agent where any artifacts are copied to before being pushed to their destination. 

More: https://docs.microsoft.com/en-us/azure/devops/pipelines/build/variables?view=azure-devops&tabs=yaml

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

# Parameters
```yaml
parameters:
- name: stageTest
  displayName: Deploy to Test
  type: boolean
  default: true
```

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

# Visual Studio build

## Publish artifact as a .zip or files
```bat
/p:PackageAsSingleFiles=true (zip)
/p:PackageAsSingleFiles=false (files)
```

# Troubleshooting

## SYSTEM_ACCESSTOKEN env var not set

Under the release, go to Agent job and check **Allow scripts to access the OAuth toke** to true.

## The reference assemblies for .NETFramework,Version=v4.8 were not found

Install the specified dotnet core + targeting pack on the build machine.

## You do not have the appropriate permissions to manage test suites under this area path.

Under Project Settings -> Boards -> Porject Configuration -> Areas. Select **Security** for the top-level area and ensure that the Build Service user has the **Manage Test Plans** and **Manage Test Suites** permissions.
