[[_TOC_]]

# Help

## help

Prints the PowerShell help section.

```console
help
```

## gcm

Searches for a specific command or a substring of a command.

```console
gcm Copy-Item
```

Or

```console
gcm *Copy-*
```

# Connectivity

## curl

```console
curl -v www.example.com
```

## Test-Connection

```console
Test-Connection -TargetName www.example.com
 ```
 
### Parameters:
 
- **-Traceroute**
- **-TcpPort <int>**

# Group management

## net group

View group information

```console
net group [GROUP NAME] /dom
```
