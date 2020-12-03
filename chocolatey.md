[[_TOC_]]

# Sources

## List

Lists the added sources.

```console
choco sources list
```

## Add

Adds a new packages source.

```console
choco sources add -n=<remote name> -s="https://www.example.se"
```

### Parameters:

- **--priority=<int>**

## Enable

Enables an already added package source.

```console
choco source enable -n=<source name>
```

## Disable

Disables a package source, but does not remove it.

```console
choco source disable -n=<source name>
```
