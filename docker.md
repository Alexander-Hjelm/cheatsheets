# Base commands

## pull

Pull an image from a remote repo.

```console
docker pull <image-url>
```

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

## attach

Attaches a shell to a running container, referenced by name

```console
docker container attach <container name> 
```
