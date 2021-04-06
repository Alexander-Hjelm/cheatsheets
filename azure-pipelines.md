# Azure Pipelines
<!--ts-->
   * [Azure Pipelines](azure-pipelines.md#azure-pipelines)
   * [Pass variables between tasks](azure-pipelines.md#pass-variables-between-tasks)
      * [write to env variable](azure-pipelines.md#write-to-env-variable)
      * [read from env variable](azure-pipelines.md#read-from-env-variable)
   * [How to use certificates with Azure Key Vault](azure-pipelines.md#how-to-use-certificates-with-azure-key-vault)
   * [Run/Build numbers](azure-pipelines.md#runbuild-numbers)

<!-- Added by: runner, at: Tue Apr  6 06:23:58 UTC 2021 -->

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

# Run/Build numbers
[Link](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/run-number?view=azure-devops&tabs=yaml)

# Windows Machine File Copy
Uses robocopy, argument list: [Link](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy)
## Troubleshooting
### Same files skipped
By default, Robocopy skips copying existing files if the specific metadata (file size, timestamp, file name) of the files match.
Override this with the `\IS` (Include same) argument.
