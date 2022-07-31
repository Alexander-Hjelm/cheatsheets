# GitHub Actions

## Workflow

### Fail, throw error

#### github-script, with error message

```yml
- name: A/B Check
  if: ${{ envA }} != ${{ envB }}
  uses: actions/github-script@v3
  with:
    script: |
        core.setFailed('envA and envB are not equivalent!')
```

#### exit()

```yml
- name: Try to fail
  if: ${{ envA }} != ${{ envB }}
  run: exit 1
```

## Custom Actions

## Specific workflow examples

### Deploy a bicep file in a GitHub Action

```yaml
name: deploy-toy-website

on: [workflow_dispatch]

env:
    AZURE_RESOURCEGROUP_NAME: ToyWebsite
    ENVIRONMENT: nonprod

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}
    - uses: azure/arm-deploy@v1
      with:
        deploymentName: ${{ github.run_number }}
        resourceGroupName: ${{ env.AZURE_RESOURCEGROUP_NAME }}
        template: ./deploy/main.bicep
        parameters: environmentType=${{ env.ENVIRONMENT }}
```
