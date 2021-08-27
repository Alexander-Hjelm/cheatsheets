# Azure CLI
<!--ts-->
* [Azure CLI](az.md#azure-cli)
* [Azure DevOps](az.md#azure-devops)
   * [Login, log in](az.md#login-log-in)
   * [Run pipeline](az.md#run-pipeline)

<!-- Added by: runner, at: Fri Aug 27 15:57:12 UTC 2021 -->

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
