# Powershell
<!--ts-->
* [Powershell](powershell.md#powershell)
* [Help](powershell.md#help)
   * [help](powershell.md#help-1)
   * [version](powershell.md#version)
   * [gcm](powershell.md#gcm)
* [IO, I/O](powershell.md#io-io)
   * [Write to console and pipe to log file at the same time](powershell.md#write-to-console-and-pipe-to-log-file-at-the-same-time)
* [Modules](powershell.md#modules)
   * [Import modules from another file](powershell.md#import-modules-from-another-file)
* [File](powershell.md#file)
   * [Replace string in file](powershell.md#replace-string-in-file)
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
      * [Join Array/ArrayList with separator](powershell.md#join-arrayarraylist-with-separator)
* [ArrayLists](powershell.md#arraylists)
   * [Assignment](powershell.md#assignment-1)
   * [Add/remove](powershell.md#addremove)
* [PSCustomObject](powershell.md#pscustomobject)
   * [Access like a dictionary](powershell.md#access-like-a-dictionary)
* [Hashtable](powershell.md#hashtable)
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
   * [Convert to HTML, example](powershell.md#convert-to-html-example)
* [Date](powershell.md#date)
* [Windows services](powershell.md#windows-services)
   * [Start/stop](powershell.md#startstop)
   * [Check status](powershell.md#check-status)
   * [Run Powershell command in new console (New window)](powershell.md#run-powershell-command-in-new-console-new-window)
* [Select-String](powershell.md#select-string)
* [ssh-keygen](powershell.md#ssh-keygen)
   * [Verify .md5 hash of a key file](powershell.md#verify-md5-hash-of-a-key-file)
* [Alert, send notification](powershell.md#alert-send-notification)
* [Add to Path, environment path](powershell.md#add-to-path-environment-path)
   * [Temporarily](powershell.md#temporarily)
   * [Permanently](powershell.md#permanently)
* [WSL](powershell.md#wsl)
   * [Mount drive in WSL](powershell.md#mount-drive-in-wsl)

<!-- Added by: runner, at: Mon Feb 14 07:33:17 UTC 2022 -->

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

# IO, I/O

## Write to console and pipe to log file at the same time
```bat
"hello" 2>&1 | tee log.txt
```

# Modules

## Import modules from another file

```bat
$script_path = dir "$($myInvocation.MyCommand.Definition)"
$script_path = $script_path.DirectoryName

Import-Module $script_path\Modules\my-module.psm1
```

# File

## Replace string in file
```bat
(Get-Content -path /my/path/file.txt -Raw) -replace 'STR_TO_REPLACE', 'TARGET_STRING' | Set-Content -Path /my/path/file.txt
```

## Encoding

Change encoding on a file:

```powershell
(Get-Content -path $(MyFilePath)) | out-file -encoding utf8 $(MyFilePath)
```

Get-Content with another encodiing:

```powershell
Get-content -Encoding utf8 "$(System.DefaultWorkingDirectory)\$(artifactname)\drop\SSASMUL\log_multi.txt"
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

### Join Array/ArrayList with separator
```bat
$myArray -join ", "
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

# PSCustomObject

## Access like a dictionary
  ```bat
$myPsCustomObject
$props = $myPsCustomObject.fields.psobject.properties
$val = $props["my key"].Value
```

# Hashtable

Example:
```bat
  name                                          value
----                                          -----
System.CurrentProcessTemplateId               89c3b34e-8b01-47c0-825a-8693ea85dbb7
System.OriginalProcessTemplateId              89c3b34e-8b01-47c0-825a-8693ea85dbb7
System.ProcessTemplateType                    6b724908-ef14-45cf-84f8-768b5384da45
System.MSPROJ                                 <?xml version="1.0" encoding="utf-8"?>...
System.Process Template                       Scrum
System.Microsoft.TeamFoundation.Team.Count    4
System.Microsoft.TeamFoundation.Team.Default  35eea91b-6561-4a88-8d13-acf205a6df04
System.SourceControlCapabilityFlags           2
System.SourceControlGitEnabled                True
System.SourceControlGitPermissionsInitialized True
```bat

## Access
  ```bat
$myHashTable.name[0]
$myHashTable.value[0]
$myHashTable.name[1]
$myHashTable.value[1]
$myHashTable.name[2]
$myHashTable.value[2]
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
  
## Convert to HTML, example
```bat
$submodulesHtml = New-Object System.Collections.ArrayList
$tags = [System.Collections.ArrayList]@(1,2,3)
$submodulesHtml.Add([ordered]@{'Remote URL' = 'abc'; 'Commit SHA' = 123; 'Tags' = $tags -join ", "})
$submodulesHtml.Add([ordered]@{'Remote URL' = 'def'; 'Commit SHA' = 456; 'Tags' = @(4,5,6)})

$submodulesHtmlConv = [pscustomobject]$submodulesHtml | ConvertTo-Json -Depth 8
$submodulesHtmlConv1 = $submodulesHtmlConv | ConvertFrom-Json
$submodulesHtmlConv2 = $submodulesHtmlConv1 | ConvertTo-Html -Fragment -As Table
$submodulesHtmlConv2
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
  
# Alert, send notification
```bat
Add-Type -AssemblyName System.Windows.Forms 
$global:balloon = New-Object System.Windows.Forms.NotifyIcon
$path = (Get-Process -id $pid).Path
$balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info 
$balloon.BalloonTipText = 'notify-send ImportTestResults-Gherkin finished!'
$balloon.BalloonTipTitle = "Attention $Env:USERNAME" 
$balloon.Visible = $true 
$balloon.ShowBalloonTip(5000)
```

# Add to Path, environment path
  
## Temporarily
```bat
$env:Path += ";my_path"
```

## Permanently
```bat
$env:Path += ";my_path"
[Environment]::SetEnvironmentVariable
     ("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
```

# WSL
```bat
wsl --list --all                    # List installed distros
wsl --list --online                 # List available distros
wsl --install -d Ubuntu             # Install a distro
wsl --export Ubuntu .\ubuntu.tar    # Export a distro to a .tar file
wsl --import Ubuntu C:\wslDistroStorage .\ubuntu.tar
```
  
## Mount drive in WSL
```bat
mkdir /mnt/t
root@CO-VDB23964S:~# sudo mount -t drvfs T: /mnt/t
```
