# Azure CLI
<!--ts-->
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
