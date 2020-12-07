# Base commands

## pull

Pull an image from a remote repo.

```console
docker pull <image-url>
```

## images

Lists all available images.

```console
docker images
```

## run

Run an image in a new container.

```console
docker run [Options] <image name/image url>
```

### Options:

- **--name** <string>
- **-i**, interactive
- **-d**, detached
- **-P**, expose ports

## exec

Exec will run a program within a container, a few examples:

```console
docker exec -i -t graceful_hopper /bin/bash
docker exec -i -t python-test python3
```

# Docker Container

## ls

Lists running containers

```console
docker container ls
```

### Options:

- **-a**: Lists historial processes as well

## stop

Stops a running containers

```console
docker container stop <container name> 
```

## rm

Removes a historical containers

```console
docker container rm <container name> 
```

## attach

Attaches a shell to a running container, referenced by name

```console
docker container attach <container name> 
```

## port

Displays exposed ports of a running container

```console
docker container port <container name> 
```

# Docker Build

## build from specified dockerfile

### Powershell
```console
Get-Content C:\Temp\MyDockerFile | docker build -t test/imagename -
```

### Bash
```console
docker build -t test/imagename - < Dockerfile
```
