# Azure CLI
<!--ts-->
* [Azure CLI](az.md#azure-cli)
* [Azure DevOps](az.md#azure-devops)
   * [Login, log in](az.md#login-log-in)
   * [Run pipeline](az.md#run-pipeline)
   * [Create release from release definition](az.md#create-release-from-release-definition)

<!-- Added by: runner, at: Wed Oct  6 08:35:45 UTC 2021 -->

<!--te-->

# Azure DevOps

## Login, log in
Save your PAT in a file (pat.txt), then:
```bash
cat pat.txt | az devops login --organization https://dev.azure.com/alexanderhjelmsolidify
```

## Run pipeline
```bash
az pipelines run --name <pipeline name>
```
or
```bash
az pipelines run --id <pipeline id>
```

## Create release from release definition
```bash
az pipelines release create --definition-name="ImportTestResults Gherkin"
```
