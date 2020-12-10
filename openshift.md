# Base commands

## project

Change active project

```console
oc project [project name]
```

## new-project

Create a new project by name

```console
oc new-project [project name]
```

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
- **repo**: Repository objects
- **service**: All service files
- **route**: All routes
- **cm**: All configmaps
- **secret**: All secrets
- **projects**: All projects

## describe

Get information on certain configuration items

```console
oc describe [OPTIONS]
```

### Options

- **bc**: All build configurations in the current project
- **bc [nameOfBuildConfig]**: A named build config

## create

Creates a resource. The type will be inferred when creating a resource from a file

```console
oc create -f secret.yaml
```

### configmap

Create a config

```console
oc create configmap [Application name] --from-literal=PARAM_NAME_1=param_value_1 --from-literal=PARAM_NAME_2=param_value_2
```

## start-build

Builds an application image

```console
oc start-build [build file name]
```

### Options

- **--from-dir=[string]**: specifies the directory for the source file(s).
- **--follow**: shows the build log in the terminal window.

## logs

```console
oc logs dc/[DeploymentConfig name] --follow
```
