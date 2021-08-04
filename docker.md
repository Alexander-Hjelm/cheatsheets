# Docker
<!--ts-->
* [Docker](docker.md#docker)
* [Base commands](docker.md#base-commands)
   * [pull](docker.md#pull)
   * [images](docker.md#images)
   * [run](docker.md#run)
      * [Options:](docker.md#options)
   * [push](docker.md#push)
      * [Options:](docker.md#options-1)
      * [Example:](docker.md#example)
   * [exec](docker.md#exec)
* [Docker Container](docker.md#docker-container)
   * [ls](docker.md#ls)
      * [Options:](docker.md#options-2)
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
* [Sample Dockerfile](docker.md#sample-dockerfile)
* [Docker Compose](docker.md#docker-compose)
   * [Sample Docker Compose file](docker.md#sample-docker-compose-file)
   * [Docker Compose commands](docker.md#docker-compose-commands)
      * [Run a docker compose file as a service](docker.md#run-a-docker-compose-file-as-a-service)
      * [Run a docker compose file in the foreground](docker.md#run-a-docker-compose-file-in-the-foreground)
      * [List images used by a docker compose file](docker.md#list-images-used-by-a-docker-compose-file)
* [Troubleshooting](docker.md#troubleshooting)
   * [The reference assemblies for .NETFramework,Version=v3.1.411 were not found... (on docker build)](docker.md#the-reference-assemblies-for-netframeworkversionv31411-were-not-found-on-docker-build)
   * [It was not possible to find any installed .NET Core SDKs (on docker run)](docker.md#it-was-not-possible-to-find-any-installed-net-core-sdks-on-docker-run)

<!-- Added by: runner, at: Wed Aug  4 11:50:39 UTC 2021 -->

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

- **-e "ENV_VAR=value"**, pass an environment variable 

## push

Push an after it has been bult

```bash
docker login
docker push <publisher name>/<image name>
```

### Options:

- **--name** <string>
- **-i**, interactive
- **-d**, detached
- **-t**, pseudo terminal
- **-P**, expose ports
- **-v**, Bind mount a volume

### Example:
```bash
docker run --name jenkins -p 8080:8080 -p 50000:50000 -v /your/home:/var/jenkins_home 1282bc63ab17
```

  
To keep the container alive: 
```bash
docker run -d -t alpine
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
docker port <container name> 
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
                                             
# Sample Dockerfile
Sample Dockerfile for a flask application
```dockerfile
# our base image
FROM alpine:3.5

# Install python and pip
RUN apk add --update py2-pip

# install Python modules needed by the Python app
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# copy files required for the app to run
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/

# tell the port number the container should expose
EXPOSE 5000

# run the application
CMD ["python", "/usr/src/app/app.py"]
```

# Docker Compose

## Sample Docker Compose file
```yaml
version: '3'
services:
  ms-sql-server:
    image: mcr.microsoft.com/mssql/server:2017-latest-ubuntu
    environment:
      ACCEPT_EULA: "Y"
      SA_PASSWORD: "Pa55w0rd2019"
      MSSQL_PID: Express
    ports:
      - "1433:1433"
  color-api:
    build: .
    environment:
      DBServer: "ms-sql-server"
    ports:
        - "8080:80"
```

## Docker Compose commands

### Run a docker compose file as a service
```bash
docker-compose start
docker-compose stop
```

### Run a docker compose file in the foreground
```bash
docker-compose up
```

### List images used by a docker compose file
```bash
docker-compose images
```

# Troubleshooting
## The reference assemblies for .NETFramework,Version=v3.1.411 were not found... (on docker build)
Add the following to you .csproj:
```xml
  <PropertyGroup>
    <TargetFramework>netcoreapp3.1</TargetFramework>
  </PropertyGroup>
```

## It was not possible to find any installed .NET Core SDKs (on docker run)
Make sure the ENTRYPOINT in your Dockerfile is pointing to the correct dll.
                                             
