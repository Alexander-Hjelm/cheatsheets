# Visual Studio
<!--ts-->
* [Visual Studio](visual-studio.md#visual-studio)
   * [Nuget](visual-studio.md#nuget)
      * [Initial nuget restore from nuget.org](visual-studio.md#initial-nuget-restore-from-nugetorg)
   * [Debugging](visual-studio.md#debugging)
      * [Debug with command arguments](visual-studio.md#debug-with-command-arguments)
      * [Troubleshooting](visual-studio.md#troubleshooting)
   * [Troubleshooting](visual-studio.md#troubleshooting-1)
      * [DLL missing](visual-studio.md#dll-missing)
      * [Running an application as a service](visual-studio.md#running-an-application-as-a-service)
         * [Specify user](visual-studio.md#specify-user)
         * [troubleshoot the service:](visual-studio.md#troubleshoot-the-service)
         * [The source was not found, but some or all event logs could not be searched. Inaccessible logs: Security](visual-studio.md#the-source-was-not-found-but-some-or-all-event-logs-could-not-be-searched-inaccessible-logs-security)
         * [Cannot start service from the command line or a debugger. A Windows Service must first be installed (using installutil.exe) and then started with the ServerExplorer, Windows Services Administrative tool or the NET START command.](visual-studio.md#cannot-start-service-from-the-command-line-or-a-debugger-a-windows-service-must-first-be-installed-using-installutilexe-and-then-started-with-the-serverexplorer-windows-services-administrative-tool-or-the-net-start-command)
      * [Files are not being delivered/copied](visual-studio.md#files-are-not-being-deliveredcopied)
      * [Subproject breakpoints are not being hit/code is not being copied to release](visual-studio.md#subproject-breakpoints-are-not-being-hitcode-is-not-being-copied-to-release)

<!-- Added by: runner, at: Sun Feb 13 12:05:31 UTC 2022 -->

<!--te-->

## Nuget

### Initial nuget restore from nuget.org

When downloading a solution for the first time, it may be missing packages.

- Right click the solution in the right hand menu
- Click "Manage NGet packages for solution"
- IN the top right, verify that you have nuget.org as the package source
  - Otherwise add "nuget.org": "https://api.nuget.org/v3/index.json"
- Update packages
- Done!

## Debugging

### Debug with command arguments

1. Go to **Debug** -> **Options**
1. Enter the command line arguments in the **Application arguments** textbox
1. Ctrl+S
1. Debug the program as usual
1. (Optionally) Set the Working directory and Exectuable to the path of your .exe, e.g. bin/Debug

### Troubleshooting

Try to run the program manually with the same arguments and see if the error persists.

## Troubleshooting

### DLL missing

Do a windows search in the packages directory of the project, after the missing dll.
If found, paste it manually in the bin/Debug or bin/Release folder. Try to build again.
If successful, this means that Visual Studio is not configured to copy the dll files upon building.

### Running an application as a service

First Build the service application from VS. Check in the bin/Debug folder of the solution for the service .exe.

Stop service manually from Services
Build solution

```powershell
sc.exe delete "TopDeskIntegration"
New-Service -Name "TopDeskIntegration" -BinaryPathName C:\Temp\TopDeskIntegration\azuredevops\integration.service\bin\Debug\NilexIntegrationService.exe
sc.exe start "TopDeskIntegration"
```

#### Specify user

You may need to specify a user to run the service as (e.g. an AD service account with correct permissions).

in Services: Right click on your service -> Properties -> Log On -> This Account -> Apecify an account with access to TFS

#### troubleshoot the service:
Event Viewer -> Applications and Service Logs

#### The source was not found, but some or all event logs could not be searched. Inaccessible logs: Security

Run the service as an administrator the first time to create the correct registry keys

#### Cannot start service from the command line or a debugger. A Windows Service must first be installed (using installutil.exe) and then started with the ServerExplorer, Windows Services Administrative tool or the NET START command.
```powershell
New-Service -Name "YourServiceName" -BinaryPathName <yourproject>.exe
```

### Files are not being delivered/copied

Check your .cs-proj-file. Verify that the there is a Content-clause covering the file that you want to deliver.

### Subproject breakpoints are not being hit/code is not being copied to release

Likely an issue with dynamically loaded assemblies. Check the debug settings. Resolved by cloning the repository again.
