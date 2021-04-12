# Azure Pipelines
<!--ts-->
   * [Azure Pipelines](azure-pipelines.md#azure-pipelines)
   * [Demands](azure-pipelines.md#demands)
      * [Agent name](azure-pipelines.md#agent-name)
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

<!-- Added by: runner, at: Mon Apr 12 07:54:54 UTC 2021 -->

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
