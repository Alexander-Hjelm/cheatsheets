[[_TOC_]]

# Help

## help

Prints the PowerShell help section.

```bat
help
```

## version

Prints the PowerShell version.
```bat
$PSVersionTable
```

## gcm

Searches for a specific command or a substring of a command.

```bat
gcm Copy-Item
```

Or

```bat
gcm *Copy-*
```

# Connectivity

## curl

```bat
curl -v www.example.com
```

## Test-Connection

```bat
Test-Connection -TargetName www.example.com
 ```
 
### Parameters:
 
- **-Traceroute**
- **-TcpPort <int>**

# User, group management

## net user

```bat
net user [USER ID] /domain
```

## net group

View group information

```bat
net group [GROUP NAME] /dom
```
