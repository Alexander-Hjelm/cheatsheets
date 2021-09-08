# Chocolatey
<!--ts-->
* [Chocolatey](chocolatey.md#chocolatey)
* [Sources](chocolatey.md#sources)
   * [List](chocolatey.md#list)
   * [Add](chocolatey.md#add)
      * [Parameters:](chocolatey.md#parameters)
   * [Enable](chocolatey.md#enable)
   * [Disable](chocolatey.md#disable)

<!-- Added by: runner, at: Wed Sep  8 10:35:08 UTC 2021 -->

<!--te-->

# Sources

## List

Lists the added sources.

```bash
choco sources list
```

## Add

Adds a new packages source.

```bash
choco sources add -n=<remote name> -s="https://www.example.se"
```

### Parameters:

- **--priority=<int>**

## Enable

Enables an already added package source.

```bash
choco source enable -n=<source name>
```

## Disable

Disables a package source, but does not remove it.

```bash
choco source disable -n=<source name>
```
