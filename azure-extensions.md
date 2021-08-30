# Azure DevOps Extensions
<!--ts-->
* [Azure DevOps Extensions](azure-extensions.md#azure-devops-extensions)
* [tfx](azure-extensions.md#tfx)
   * [Build an extension](azure-extensions.md#build-an-extension)
   * [Publish an extension](azure-extensions.md#publish-an-extension)

<!-- Added by: runner, at: Mon Aug 30 13:48:14 UTC 2021 -->

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