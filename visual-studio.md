# Visual Studio
<!--ts-->
* [Visual Studio](visual-studio.md#visual-studio)
   * [Troubleshooting](visual-studio.md#troubleshooting)
      * [DLL missing](visual-studio.md#dll-missing)
      * [Running an application as a service](visual-studio.md#running-an-application-as-a-service)
         * [The source was not found, but some or all event logs could not be searched. Inaccessible logs: Security](visual-studio.md#the-source-was-not-found-but-some-or-all-event-logs-could-not-be-searched-inaccessible-logs-security)
         * [Cannot start service from the command line or a debugger. A Windows Service must first be installed (using installutil.exe) and then started with the ServerExplorer, Windows Services Administrative tool or the NET START command.](visual-studio.md#cannot-start-service-from-the-command-line-or-a-debugger-a-windows-service-must-first-be-installed-using-installutilexe-and-then-started-with-the-serverexplorer-windows-services-administrative-tool-or-the-net-start-command)

<!-- Added by: runner, at: Sun Oct 17 16:15:08 UTC 2021 -->

<!--te-->

## Troubleshooting

### DLL missing

Do a windows search in the packages directory of the project, after the missing dll.
If found, paste it manually in the bin/Debug or bin/Release folder. Try to build again.
If successful, this means that Visual Studio is not configured to copy the dll files upon building.

### Running an application as a service

First Build the service application from VS. Check in the bin/Debug folder of the solution for the service .exe.

```powershell
sc.exe delete "MyServiceName"
New-Service -Name "MyServiceName" -BinaryPathName C:\Temp\Full\Path\To\MyService.exe
```

#### The source was not found, but some or all event logs could not be searched. Inaccessible logs: Security

Run the service as an administrator the first time to create the correct registry keys

#### Cannot start service from the command line or a debugger. A Windows Service must first be installed (using installutil.exe) and then started with the ServerExplorer, Windows Services Administrative tool or the NET START command.
```powershell
New-Service -Name "YourServiceName" -BinaryPathName <yourproject>.exe
```
