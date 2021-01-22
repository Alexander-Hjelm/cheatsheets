# Powershell
<!--ts-->
   * [Powershell](powershell.md#powershell)
   * [Help](powershell.md#help)
      * [help](powershell.md#help-1)
      * [version](powershell.md#version)
      * [gcm](powershell.md#gcm)
   * [Connectivity](powershell.md#connectivity)
      * [curl](powershell.md#curl)
      * [Test-Connection](powershell.md#test-connection)
         * [Parameters:](powershell.md#parameters)
   * [User, group management](powershell.md#user-group-management)
      * [net user](powershell.md#net-user)
      * [net group](powershell.md#net-group)

<!-- Added by: runner, at: Fri Jan 22 13:52:50 UTC 2021 -->

<!--te-->

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
