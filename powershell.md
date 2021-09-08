# Powershell
<!--ts-->
* [Powershell](powershell.md#powershell)
* [Help](powershell.md#help)
   * [help](powershell.md#help-1)
   * [version](powershell.md#version)
   * [gcm](powershell.md#gcm)
* [Types, datatypes](powershell.md#types-datatypes)
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
      * [Contains](powershell.md#contains)
* [ArrayLists](powershell.md#arraylists)
   * [Assignment](powershell.md#assignment-1)
   * [Add/remove](powershell.md#addremove)
* [control statements](powershell.md#control-statements)
   * [if/else](powershell.md#ifelse)
      * [logical operators](powershell.md#logical-operators)
   * [for](powershell.md#for)
   * [foreach](powershell.md#foreach)
      * [foreach line in file](powershell.md#foreach-line-in-file)
* [regex](powershell.md#regex)
   * [-match](powershell.md#-match)
* [arguments](powershell.md#arguments)
   * [simple argument get](powershell.md#simple-argument-get)
   * [parameters or default values](powershell.md#parameters-or-default-values)
   * [Navigation](powershell.md#navigation)
      * [Subfiles, subfolders](powershell.md#subfiles-subfolders)
* [Strings](powershell.md#strings)
   * [Trim](powershell.md#trim)
* [Data types](powershell.md#data-types)
   * [Convert](powershell.md#convert)
      * [String to Int](powershell.md#string-to-int)
* [Date](powershell.md#date)
* [Windows services](powershell.md#windows-services)
   * [Start/stop](powershell.md#startstop)
   * [Check status](powershell.md#check-status)
   * [Run Powershell command in new console (New window)](powershell.md#run-powershell-command-in-new-console-new-window)
* [Select-String](powershell.md#select-string)
* [ssh-keygen](powershell.md#ssh-keygen)
   * [Verify .md5 hash of a key file](powershell.md#verify-md5-hash-of-a-key-file)

<!-- Added by: runner, at: Wed Sep  8 10:29:49 UTC 2021 -->

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

# Types, datatypes

- [string]    Fixed-length string of Unicode characters
- [char]      A Unicode 16-bit character
- [byte]      An 8-bit unsigned character

- [int]       32-bit signed integer
- [long]      64-bit signed integer
- [bool]      Boolean True/False value

- [decimal]   A 128-bit decimal value
- [single]    Single-precision 32-bit floating point number
- [double]    Double-precision 64-bit floating point number
- [DateTime]  Date and Time

- [xml]       Xml object
- [array]     An array of values
- [hashtable] Hashtable object

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

### Contains

```bat
$array.Contains("value")
```

# ArrayLists

## Assignment

```bat
[System.Collections.ArrayList]$arraylist = @()
```

## Add/remove

```bat
$arraylist.Add("value")
$arraylist.Remove("value")
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

### logical operators
```bat
-And
-Or

-eq
-ne
-gt
-ge
-lt
-le
```

## for
```bat
for ($i = 0 ; $i -lt 10 ; $i++){
    echo $i
}
```

## foreach
```bat
foreach ($line in $output) {
    // Do something
}
```

### foreach line in file
```bat
foreach($line in Get-Content .\file.txt) {
        # Work here
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

# arguments

## simple argument get
```bat
$var_name = $args[0]
```

## parameters or default values
```bat
param (
    [string]$price = 100, 
    [string]$ComputerName = $env:computername,    
    [string]$username = $(throw "-username is required."),
    [string]$password = $( Read-Host -asSecureString "Input password" ),
    [switch]$SaveData = $false
)
```

## Navigation

### Subfiles, subfolders
Find a subfile or subfolder with an unknown relative path
```bat
$aPath = Get-Child-Item -Recurse -Filter a.txt | Resolve-Path
$bPath = Get-Child-Item -Recurse -Filter b.txt | Resolve-Path

Remove-Item $bPath
Rename-Item $aPath b.txt
```

# Strings

## Trim

Trim leading and trailling spaces
```bat
$a = " abc ".trim()
```

# Data types

## Convert

### String to Int
```bat
$integerN = [int]$stringN
```

# Date
```bat
Get-Date -Format "dddd MM/dd/yyyy HH:mm K"
```

# Windows services

## Start/stop
```bat
Start-Service [Service name] -PassThru
Stop-Service [Service name] -PassThru
```

## Check status
```bat
services.msc
```

## Run Powershell command in new console (New window)
```bat
Start-Process PowerShell -ArgumentList "Get-Date; Read-Host 'Press Enter'"
Start-Process PowerShell -ArgumentList "./my-script.ps1; Read-Host 'Press Enter'"
```

# Select-String
Find, grep
```bat
[Command] | Select-String [search-string]
```

# ssh-keygen

## Verify .md5 hash of a key file
  ```bat
  C:\Users\alexander\.ssh>ssh-keygen -l -E md5 -f id_rsa
  ```
  
