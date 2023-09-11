# Windows Server Administration

<!--ts-->
<!--te-->

## Process admin

### Force kill a service

If a service is not responding to Stop/Restart commands, you can try the following:

- Find the service name in **Services** 
- Open a command prompt as administrator
- `sc queryex <Service Name>`
- Find the service `PID`
- `taskkill /f /pid <PID>`

This can fix error messages such as the following in **Services**:

```log
The service cannot accept control messages at this time
```

and the following in Event Logger > Application logs:

```log
Failed to stop service. System.ArgumentException: Invalid eventID value '68064'. It must be in the range between '0' and '65535'.
```
