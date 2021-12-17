# Azure DevOps Extensions
<!--ts-->
* [Azure DevOps Extensions](azure-extensions.md#azure-devops-extensions)
* [tfx](azure-extensions.md#tfx)
   * [Build an extension](azure-extensions.md#build-an-extension)
   * [Publish an extension](azure-extensions.md#publish-an-extension)
   * [Sample build script](azure-extensions.md#sample-build-script)
* [Tasks](azure-extensions.md#tasks)
   * [inputs, task.json](azure-extensions.md#inputs-taskjson)
* [Make an extension public](azure-extensions.md#make-an-extension-public)
* [Work Item API](azure-extensions.md#work-item-api)
   * [Index of all work item fields](azure-extensions.md#index-of-all-work-item-fields)
   * [Index of work item links](azure-extensions.md#index-of-work-item-links)
   * [Custom work item fields](azure-extensions.md#custom-work-item-fields)
   * [Acess Rest API from react](azure-extensions.md#acess-rest-api-from-react)
* [Troubleshooting](azure-extensions.md#troubleshooting)
   * [The extension '' doesn't contain the requested asset type 'XXX.xxx'](azure-extensions.md#the-extension--doesnt-contain-the-requested-asset-type-xxxxxx)
   * [Refused to apply style because its MIME type ('application/json') is not a supported](azure-extensions.md#refused-to-apply-style-because-its-mime-type-applicationjson-is-not-a-supported)
   * [Uncaught ReferenceError: VSS is not defined](azure-extensions.md#uncaught-referenceerror-vss-is-not-defined)

<!-- Added by: runner, at: Fri Dec 17 10:41:11 UTC 2021 -->

<!--te-->

# tfx

## Build an extension
```bash
tfx extension create --manifest-globs vss-extension.json --rev-version
```

## Publish an extension
```bash
tfx extension publish --share-with AlexanderHjelmSolidify --rev-version --token <PAT>
```

## Sample build script
```bash
# Install az cli: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli
#npm install -g tfx-cli
#npm install -g typescript

python3 bumpversion.py
tsc -p C:\dev\ImportTestresults-gherkin\importTestresultsTask\tsconfig.json
tfx extension create --manifest-globs vss-extension.json --rev-version

tfx extension publish --publisher alexanderhjelmsolidifytest --share-with AlexanderHjelmSolidify --env mode=development --no-wait-validation --token cpb4mo3kndlvawrw7ggmhvf5nxbxfi3plf3zsyntaobsbldhk6pq

cat pat.txt | az devops login --organization https://dev.azure.com/alexanderhjelmsolidify

az pipelines run --name testproject-CI
#az pipelines release create --definition-name="ImportTestResults Gherkin"
```

# Tasks

## inputs, task.json
```json
    "inputs": [
        {
            "name": "sourcePath",
            "type": "filePath",
            "label": "Testresults filepath",
            "defaultValue": "",
            "required": true,
            "helpMarkDown": "Full path to testresults directory, ie:$(build.artifactstagingdirectory)"
        },
        {
            "name": "testPlan",
            "type": "string",
            "label": "Name of TestPlan",
            "defaultValue": "",
            "required": true,
            "helpMarkDown": "Name of TestPlan to look for Testcases in"
        },
        {
            "name": "createTC",
            "type": "boolean",
            "label": "Create Test Cases",
            "defaultValue": false,
            "required": false,
            "helpMarkDown": "Check this if you want to automatically create Test Cases in the selected Test Plan in Azure DevOps"
        },
        {
            "name": "fileType",
            "type": "radio",
            "label": "File type",
            "required": true,
            "defaultValue": "Gherkin",
            "helpMarkDown": "Which type of file to parse.",
            "options": {
                "Gherkin": "Gherkin",
                "TestNG": "TestNG"
            }
        }
    ],
```

# Make an extension public

Set the following in the extension manifest:

```json
    "public": false,
```

# Work Item API

## Index of all work item fields

https://docs.microsoft.com/en-us/azure/devops/boards/work-items/guidance/work-item-field?view=azure-devops

## Index of work item links

https://docs.microsoft.com/en-us/azure/devops/boards/queries/link-type-reference?view=azure-devops

## Custom work item fields

Format: `/fields/Custom.Fields.<field name>`

## Acess Rest API from react

```
import {
  WorkItemTrackingRestClient,
  Wiql
} from "azure-devops-extension-api/WorkItemTracking";
import { getClient } from "azure-devops-extension-api";
    let client = getClient(WorkItemTrackingRestClient);

    let wiql: Wiql = {query: "SELECT [System.Id], FROM WorkItems WHERE [Work Item Type] = 'Bug'"};
    let result = await client.queryByWiql(wiql);
```

# Troubleshooting

## The extension '' doesn't contain the requested asset type 'XXX.xxx'

Add the specified file in the "files" field of the extension manifest:

```json
    "files": [
        {
            "path": "wsjfSettings.html",
            "addressable": true
        }
    ]
```

## Refused to apply style because its MIME type ('application/json') is not a supported
Add the specified css in the "files" field of the extension manifest:

```json
    "files": [
        {
            "path": "css",
            "addressable": true
        }
    ]
```


## Uncaught ReferenceError: VSS is not defined
Add the missing reference in the "files" field of the extension manifest:

```json
    "files": [
        {
            "path": "node_modules/vss-web-extension-sdk/lib",
            "addressable": true,
            "packagePath": "lib"
        }
    ]
```
