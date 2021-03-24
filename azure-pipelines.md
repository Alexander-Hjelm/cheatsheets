# Azure Pipelines
<!--ts-->
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
