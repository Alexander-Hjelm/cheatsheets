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
   * [Find host platform](powershell.md#find-host-platform)
   * [Arrays](powershell.md#arrays)
      * [Assignment](powershell.md#assignment)
      * [Access](powershell.md#access)
         * [By index](powershell.md#by-index)
      * [Read lines into array](powershell.md#read-lines-into-array)
      * [Properties](powershell.md#properties)
         * [Count](powershell.md#count)
   * [control statements](powershell.md#control-statements)
      * [if/else](powershell.md#ifelse)
      * [for](powershell.md#for)
      * [foreach](powershell.md#foreach)
   * [regex](powershell.md#regex)
      * [-match](powershell.md#-match)

<!-- Added by: runner, at: Mon Feb  1 09:31:42 UTC 2021 -->

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

# Find host platform

```bat
if ($IsLinux) {
    Write-Host "Linux"
}
elseif ($IsMacOS) {
    Write-Host "macOS"
}
elseif ($IsWindows) {
    Write-Host "Windows"
}
```
# Arrays

## Assignment
```bat
$array = @(1,2,3, "go!")
```

## Access

### By index
```bat
echo $array[1]
```

## Read lines into array
```bat
$array = [command]
```

## Properties

### Count

```bat
$array.count
```

# control statements

## if/else
```bat
if(Boolean_expression) {
   // Executes when the Boolean expression is true
}else {
   // Executes when the Boolean expression is false
}
```

## for
```bat
for ($i = 1 ; $i -le 10 ; $i++){
    echo $i
}
```

## foreach
```bat
foreach ($line in $output) {
    // Do something
}
```

# regex

## -match
The -match opperator takes a regular expression and returns $true if the pattern matches.

An automatic variable called **$Matches** contains the results of the match.
```bat
PS> '123-45-6789' -match '\d\d\d-\d\d-\d\d\d\d'
True

$message = 'My SSN is 123-45-6789.'
$message -match 'My SSN is (\d\d\d-\d\d-\d\d\d\d)\.'
$Matches[0]
$Matches[1]

My SSN is 123-45-6789.
123-45-6789
```
