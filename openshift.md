# Openshift
<!--ts-->
* [Openshift](openshift.md#openshift)
* [Base commands](openshift.md#base-commands)
   * [project](openshift.md#project)
   * [new-project](openshift.md#new-project)
   * [get](openshift.md#get)
      * [Options](openshift.md#options)
   * [describe](openshift.md#describe)
      * [Options](openshift.md#options-1)
   * [create](openshift.md#create)
      * [configmap](openshift.md#configmap)
   * [start-build](openshift.md#start-build)
      * [Options](openshift.md#options-2)
   * [logs](openshift.md#logs)
   * [rsh](openshift.md#rsh)

<!-- Added by: runner, at: Fri Jul 16 10:53:31 UTC 2021 -->

<!--te-->

# Base commands

## project

Change active project

```bash
oc project [project name]
```

## new-project

Create a new project by name

```bash
oc new-project [project name]
```

## get

Get certain configuration items

```bash
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

```bash
oc describe [OPTIONS]
```

### Options

- **bc**: All build configurations in the current project
- **bc [nameOfBuildConfig]**: A named build config

## create

Creates a resource. The type will be inferred when creating a resource from a file

```bash
oc create -f secret.yaml
```

### configmap

Create a config

```bash
oc create configmap [Application name] --from-literal=PARAM_NAME_1=param_value_1 --from-literal=PARAM_NAME_2=param_value_2
```

## start-build

Builds an application image

```bash
oc start-build [build file name]
```

### Options

- **--from-dir=[string]**: specifies the directory for the source file(s).
- **--follow**: shows the build log in the terminal window.

## logs

```bash
oc logs dc/[DeploymentConfig name] --follow
```

## rsh

Open a remote shell to a running pod.

```bash
oc rsh [Pod name]
```
