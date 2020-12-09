# Base commands

## get

Get certain configuration items

```console
oc get [OPTIONS]
```

### Options

- **all**: All configuration items
- **bc**: All build configurations in the current project
- **bc [nameOfBuildConfig]**: A named build config
- **bc [nameOfBuildConfig] -o yaml**: Print a named build config as yaml
- **dc**: All deploy configurations in the current project
- **pods**: All running pods in the current project

## describe

Get information on certain configuration items

```console
oc describe [OPTIONS]
```

### Options

- **bc**: All build configurations in the current project
- **bc [nameOfBuildConfig]**: A named build config

## start-build

Builds an application image

```console
oc start-build [build file name]
```

### Options

- **--from-dir=[string]**: specifies the directory for the source file(s).
- **--follow**: shows the build log in the terminal window.
