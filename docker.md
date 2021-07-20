# Docker
<!--ts-->
* [Docker](docker.md#docker)
* [Base commands](docker.md#base-commands)
   * [pull](docker.md#pull)
   * [images](docker.md#images)
   * [run](docker.md#run)
      * [Options:](docker.md#options)
      * [Example:](docker.md#example)
   * [exec](docker.md#exec)
* [Docker Container](docker.md#docker-container)
   * [ls](docker.md#ls)
      * [Options:](docker.md#options-1)
   * [stop](docker.md#stop)
   * [rm](docker.md#rm)
   * [attach](docker.md#attach)
   * [port](docker.md#port)
* [Docker Build](docker.md#docker-build)
   * [build from context](docker.md#build-from-context)
   * [build from specified dockerfile](docker.md#build-from-specified-dockerfile)
      * [Powershell](docker.md#powershell)
      * [Bash](docker.md#bash)
   * [Build from context with dockerfile](docker.md#build-from-context-with-dockerfile)

<!-- Added by: runner, at: Mon Jul 19 12:26:55 UTC 2021 -->

<!--te-->

# Base commands

## pull

Pull an image from a remote repo.

```bash
docker pull <image-url>
```

## images

Lists all available images.

```bash
docker images
```

## run

Run an image in a new container.

```bash
docker run [Options] <image name/image url> <command to run>
```

### Options:

- **--name** <string>
- **-i**, interactive
- **-d**, detached
- **-P**, expose ports
- **-v**, Bind mount a volume

### Example:
```bash
docker run --name jenkins -p 8080:8080 -p 50000:50000 -v /your/home:/var/jenkins_home 1282bc63ab17
```

## exec

Exec will run a program within a container, a few examples:

```bash
docker exec -i -t graceful_hopper /bin/bash
docker exec -i -t python-test python3
```

# Docker Container

## ls

Lists running containers

```bash
docker container ls
```

### Options:

- **-a**: Lists historial processes as well

## stop

Stops a running containers

```bash
docker container stop <container name> 
```

## rm

Removes a historical containers

```bash
docker container rm <container name> 
```

## attach

Attaches a shell to a running container, referenced by name

```bash
docker container attach <container name> 
```

## port

Displays exposed ports of a running container

```bash
docker container port <container name> 
```

# Docker Build

## build from context
```bash
docker build -t test/restapp .
```

## build from specified dockerfile

### Powershell
```bash
Get-Content C:\Temp\MyDockerFile | docker build -t test/imagename -
```

### Bash
```bash
docker build -t test/imagename - < Dockerfile
```
                                             
## Build from context with dockerfile
```bash
docker image build -t secret-scanner/web .
```

**-t**: specifies image name and tag
                                             
