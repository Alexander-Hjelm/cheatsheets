# Azure DevOps Extensions
<!--ts-->
* [Azure DevOps Extensions](azure-extensions.md#azure-devops-extensions)
* [tfx](azure-extensions.md#tfx)
   * [Build an extension](azure-extensions.md#build-an-extension)
   * [Publish an extension](azure-extensions.md#publish-an-extension)

<!-- Added by: runner, at: Wed Sep 22 11:25:54 UTC 2021 -->

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
