# Azure DevOps Extensions
<!--ts-->

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
