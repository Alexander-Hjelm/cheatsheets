# Azure Pipelines
<!--ts-->
   * [Azure Pipelines](azure-pipelines.md#azure-pipelines)
   * [Pass variables between tasks](azure-pipelines.md#pass-variables-between-tasks)
      * [write to env variable](azure-pipelines.md#write-to-env-variable)
      * [read from env variable](azure-pipelines.md#read-from-env-variable)
   * [How to use certificates with Azure Key Vault](azure-pipelines.md#how-to-use-certificates-with-azure-key-vault)

<!-- Added by: runner, at: Wed Mar 31 11:21:27 UTC 2021 -->

<!--te-->

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

# How to use certificates with Azure Key Vault
[Link](https://www.dotnetcurry.com/devops/1507/azure-key-vault-secrets-pipelines)
