# Godot C#

## Install 3rd party NuGet packages

In the same folder as the project .sln file, do:

```ps1
dotnet add package Newtonsoft.Json
```

## RPCMode

- **Remote**: Calls and property changes are accepted from all remote peers, no matter if they are node's master or puppets.
- **Master**: To be called only on the network master for this node.
- **Slave**: To be called only on the network puppets for this node.

## user://

By default, `user://` points to `C:\Users\AlexanderHjelm\AppData\Roaming\Godot\app_userdata\<Project Name>`
