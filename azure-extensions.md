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
* [Create hubs](azure-extensions.md#create-hubs)
* [Local testing](azure-extensions.md#local-testing)
   * [Testing node pipeline tasks in Visual Studio](azure-extensions.md#testing-node-pipeline-tasks-in-visual-studio)
   * [Testing widgets and work item forms with webpack serve](azure-extensions.md#testing-widgets-and-work-item-forms-with-webpack-serve)
   * [Read system variables in pipeline](azure-extensions.md#read-system-variables-in-pipeline)
* [Troubleshooting](azure-extensions.md#troubleshooting)
   * [The extension '' doesn't contain the requested asset type 'XXX.xxx'](azure-extensions.md#the-extension--doesnt-contain-the-requested-asset-type-xxxxxx)
   * [Refused to apply style because its MIME type ('application/json') is not a supported](azure-extensions.md#refused-to-apply-style-because-its-mime-type-applicationjson-is-not-a-supported)
   * [Uncaught ReferenceError: VSS is not defined, Can't resolve 'TFS' or 'VSS'](azure-extensions.md#uncaught-referenceerror-vss-is-not-defined-cant-resolve-tfs-or-vss)
   * [Error: Node Sass does not yet support your current environment: Linux 64-bit with Unsupported runtime (93)](azure-extensions.md#error-node-sass-does-not-yet-support-your-current-environment-linux-64-bit-with-unsupported-runtime-93)
   * [Field 'browser' doesn't contain a valid alias configuration](azure-extensions.md#field-browser-doesnt-contain-a-valid-alias-configuration)

<!-- Added by: runner, at: Mon Feb 14 07:33:10 UTC 2022 -->

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

# Create hubs
Follow this guide:
https://docs.microsoft.com/en-us/azure/devops/extend/get-started/node?view=azure-devops

You can use different targets to put the hub in different places, e.g.:
**"ms.vss-code-web.code-hub-group"** for Repos, and
**"ms.vss-web.collection-admin-hub-group"** for collection settings

# Local testing

## Testing node pipeline tasks in Visual Studio

Node tasks can be debugged locally by invoking them with npm and supplying the environment variables.

In VS Code, you can set up the following debug configuration:

**.vscode/launch.json**:
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "type": "node",
            "request": "launch",
            "name": "Launch Program",
            "env": {
                "INPUT_parameter_boolean": "false",
                "INPUT_parameter_string": "mystr",
                "INPUT_parameter_num": 12345,
                "SYSTEM_DEFAULTWORKINGDIRECTORY": "C:\\ProjectFolder",
                "SYSTEM_TEAMPROJECT": "testproject",
                "SYSTEM_TEAMFOUNDATIONCOLLECTIONURI": "https://dev.azure.com/solidify/",
                "SYSTEM_ACCESSTOKEN": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
            },
            "program": "${workspaceFolder}/dist/index.js",
            "outFiles": [
                "${workspaceFolder}/**/*js"
            ]
        }
    ]
}
```


**.vscode/tasks.json**:
```json
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
         {
             "type": "typescript",
             "tsconfig": "src/importTestresultsTask/tsconfig.json",
             "problemMatcher": [
                 "$tsc"
             ],
            "group": "build"
         }
    ]
}
```

## Testing widgets and work item forms with webpack serve

With webpack you may build a local version of your extension that you can inject into the relevant html form elements of your Azure DevOps organization.

First create an overrides JSON file with the following content for your dev build in **configs/dev.json**:
```json
{
  "id": "[extension-id]-dev",
  "public": false,
  "baseUri": "https://localhost:3000"
}
```
And an overrides JSON file for the release build called **configs/release.json**:
```json
{
  "id": "[extension-id]",
  "public": true
}
```

Your **webpack.config.js** should contain the output (dist) directory and information about the devServer:
```javascript
module.exports = {
  devtool: "inline-source-map",
  devServer: {
    https: true,
    port: 3000
  },
  output: {
    publicPath: "/dist/"
    // ...
  }
  // ...
};
```

Additionally, in order to make webpack copy HTML files from the src folder to the dist folder, you need to add the copy-webpack-plugin npm package to your project, and then add the following lines to your **webpack.config.json** file. These changes will configure webpack to copy all HTML files from src:
```javascript
const CopyWebpackPlugin = require("copy-webpack-plugin");
// ...

module.exports = {
  plugins: [new CopyWebpackPlugin([{ from: "**/*.html", context: "src" }])],
  // ...
};
```

If you want a debug configuration in VS Code that serves the extension instead, you can use the following **.vscode/launch.json**:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Launch Firefox",
      "type": "firefox",
      "request": "launch",
      "url": "https://localhost:3000/",
      "reAttach": true,
      "pathMappings": [
        {
          "url": "webpack:///",
          "path": "${workspaceFolder}/"
        }
      ]
    }
  ]
}
```

Your **package.json** should contain the following scripts for compiling the dev version of your extension:
```json
"clean": "rimraf ./dist ./out",
"compile:dev": "npm run clean && webpack --mode development",
"build": "npm run compile",
"build:dev": "npm run compile:dev",
"package-extension:dev": "npm run compile:dev && tfx extension create --overrides-file configs/dev.json --manifest-globs vss-extension.json",
"package-extension:prod": "npm run compile && tfx extension create --overrides-file configs/release.json --manifest-globs vss-extension.json",
"publish-extension": "tfx extension publish --manifest-globs vss-extension.json",
"start:dev": "webpack serve --mode development",
```

Now we need to do the following steps:
- Compile your dev extension vsix with `npm run package:dev`
- Publish the extension, either manually through the Manage Extensions portal or with `npm run publish-extension`
- Share your dev extension with your AzDO organization.
- Run your dev extension with `npm run start:dev`. This should open a terminal saying your extension is being served from https://localhost:3000. The extension will be continously built and served as long as this console is open, allowing you to edit the code and view the results without republishing.
- Now you will need to navigate to https://localhost:3000 in a web browser and click past the security warning, telling the browser to trust localhost:3000. Otherwise the injected html forms will not render.
- Now navigate to your AzDO organization and install the extension. Then do any neccessary configuration on your dasboard/process templates/etc and you are done.

## Read system variables in pipeline
```
npm install azure-pipelines-task-lib
```

```ts
import tl = require('azure-pipelines-task-lib/task');
const organizationUrl = tl.getVariable('System.TeamFoundationCollectionUri');
const token = tl.getVariable('System.AccessToken');
```

# Installing a Work Item form extenion on AzDO on-prem

After installing the extension in the Gallery, you will need to edit the process model for your project (Can be scripted across many projects).

Download the models with witadmin:
```pwsh
cd 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer'
.\witadmin.exe exportwitd /collection:https://tfstest.dd.dll.se/DefaultCollection /p:Integration /n:"User Story" /f:Integration_userstory.xml
.\witadmin.exe exportwitd /collection:https://tfstest.dd.dll.se/DefaultCollection /p:Integration /n:"Bug" /f:Integration_bug.xml
...
```

Under the "Work Item Extensions" comment, add a reference to your extension:
```xml
<Extensions>
   <Extension Id="example.color-control-dev" />
</Extensions>
```

And then add a new page. The id should match the pattern: [Publisher id].[Extension id].[contribution id]:
```xml
<Page Label="Time Tracking" LayoutMode="FirstColumnWide">
  <Section>
    <GroupContribution Label="Time Tracking" Id="Solidify.sormland-timetracker-wi-link.lean-budget-group" />
  </Section>
</Page>
```

Finally import the models again:
```pwsh
.\witadmin.exe importwitd /collection:https://tfstest.dd.dll.se/DefaultCollection /f:C:\Users\Alehje\Desktop\Integration_bug.xml /p:Integration
```

Reference: https://docs.microsoft.com/en-us/azure/devops/extend/develop/configure-workitemform-extensions?view=azure-devops

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


## Uncaught ReferenceError: VSS is not defined, Can't resolve 'TFS' or 'VSS'
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

When building with webpack, make sure that the externals are defined in webpack.config.js:  
```js
externals: [
/^VSS\/.*/, /^TFS\/.*/, /^q\/.*/
],
```

And that the types are defined in tsconfig:
```js
"types": [
    "react",
    "jest",
    "node",
    "vss-web-extension-sdk"
],
```

## Error: Node Sass does not yet support your current environment: Linux 64-bit with Unsupported runtime (93)

Upgrade `node-sass` and `sass-loader` to latest versions.

## Field 'browser' doesn't contain a valid alias configuration

Issue with webpack module rules. The entry is either a folder or is not getting picked up by any of your rules.

