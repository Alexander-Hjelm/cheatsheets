# Visual Studio Code

## Search with Regex groups

- Ctrl + F
- Click the .* button

Example, the following search/replace pattern:

```
([A-Za-z0-9_]*) \(([a-z., ]*)\)
| $1 | $2 |
```

Example:
```
AM12-PDP (.js, .js.map, .tiff, .svg, etc...)
| AM12-PDP | .js, .js.map, .tiff, .svg, etc... |
```

## Search for keywords and cut out lines

Do a regex search with the following pattern:

```
^.*(word1|word2|word3).*\n?
```

With the search window still active, press **alt+enter** to select all matching lines, then either **delete** och **ctrl-c/x**

## Build configurations for a dotnet core console application

You can scaffold the `launch.json` and `tasks.json` file by doing `Ctrl+Shift+P` and running the **.NET: Generate Assets for Build and Debug** task.

Here are some samples:

### launch.json

```json
{
    "version": "0.2.0",
    "configurations": [
        {
           "name": ".NET Core Launch (console)",
            "type": "coreclr",
            "request": "launch",
            "preLaunchTask": "build",
            "program": "${workspaceFolder}/src/<projectName>/bin/Debug/net7.0/<programName>.dll",
            "args": ["run",
                "-n",
                "Export",
                "-v",
                "V1"
            ],
            "cwd": "${workspaceFolder}/src/<projectName>",
            "console": "internalConsole",
            "stopAtEntry": false,
            "logging": {
                "moduleLoad": false
            },
        }
    ]
}
```

### tasks.json

```json
{
    "version": "2.0.0",
    "tasks": [
            {
            "label": "prepare",
            "type": "shell",
            "command": "echo 'Ready!'",
            "group": "build",
        },
        {
            "label": "build",
            "command": "dotnet",
            "type": "process",
            "args": [
                "build",
                "${workspaceFolder}/src/<projectName>.csproj",
                "/property:GenerateFullPaths=true",
                "/consoleloggerparameters:NoSummary"
            ],
            "problemMatcher": "$msCompile",
            "dependsOn":["prepare"]
        },
        {
            "label": "test",
            "command": "dotnet",
            "type": "process",
            "args": [
                "test"
            ],
            "isTestCommand": true,
            "problemMatcher": "$msCompile"
        }
    ]
}
```

## VS Code Hotkeys

- **ctrl+p**            Open Command Palette
- **ctrl+p: >**	        Run Command
- **ctrl+p: @**	        Symbol search
- **ctrl+p: #**	        Global Symbol search
- **alt+up/down**	    Move current line up/down
- **home**		        Move cursor to beginning of line
- **end**		        Move cursor to end of line
- **ctrl+c**	    	Copy Line
- **ctrl+v**		    Paste Line
- **ctrl+x**		    Cut Line
- **ctrl+'**		    Line Comment
- **shift+alt+A**	    Multiline Comment
- **ctrl+k, ctrl+s**	Edit Keyboard Shortcuts
- **ctrl+shift+ö**	    Open a new terminal
