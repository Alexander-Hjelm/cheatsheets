

## Troubleshooting

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
