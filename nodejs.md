# Node js

<!--ts-->
* [Node js](nodejs.md#node-js)
   * [Hello world](nodejs.md#hello-world)
   * [command line](nodejs.md#command-line)
      * [Execute/run a program](nodejs.md#executerun-a-program)
   * [modules](nodejs.md#modules)
      * [export/import](nodejs.md#exportimport)
   * [Files, IO](nodejs.md#files-io)
      * [Read file](nodejs.md#read-file)
      * [Write file](nodejs.md#write-file)
      * [os.walk, iterate through files, subfolders](nodejs.md#oswalk-iterate-through-files-subfolders)
   * [Events](nodejs.md#events)

<!-- Added by: runner, at: Mon Jul 19 12:02:50 UTC 2021 -->

<!--te-->

## Hello world
```javascript
function sayHello(name) {
    console.log(name);
}

sayHello("Hello world")
```


## command line

### Execute/run a program
```bash
node app.js
```

## modules

### export/import

**Export**:
```bash
const url = "http:/mylogger.io"
function log(s) {console.log(s)}

module.exports.log = log
module.exports.endpoint = url
```

**Import**:
```bash
const logger = require('./logger.js')
```

## Files, IO

### Read file
```typescript
const fs = require("fs")
fs.readFile('input.txt', function (err, data) {
  if (err) {
    return console.error(err);
  }
    console.log("Asynchronous read: " + data.toString());
});
```

### Write file
```typescript
const fs = require("fs")
fs.writeFile('input.txt', 'Simply Easy Learning!', function(err) {
  if (err) {
    return console.error(err);
  }
  console.log("Data written successfully!");
});
```

### os.walk, iterate through files, subfolders
```typescript
const fs = require("fs")
const path = require("path")

// Config
src_path = "/home/groove/dev/confluence-to-azdo/505632453"

const getAllFiles = function(dirPath, arrayOfFiles) {
  files = fs.readdirSync(dirPath)

  arrayOfFiles = arrayOfFiles || []

  files.forEach(function(file) {
    if (fs.statSync(dirPath + "/" + file).isDirectory()) {
      arrayOfFiles = getAllFiles(dirPath + "/" + file, arrayOfFiles)
    } else {
      arrayOfFiles.push(path.join(__dirname, dirPath, "/", file))
    }
  })

  return arrayOfFiles
}

const arrayOfFiles = getAllFiles(src_path)
console.log(arrayOfFiles)
```

## Events
```typescript
const EventEmitter = require('events')
const emitter = new EventEmitter();

// Register a listener
emitter.on("messageLogged", (arg) => {
  console.log("Listener called: " + arg.arg1 + ", " + arg.arg2);
});

// Raise an event
emitter.emit("messageLogged", {arg1: "lol", arg2: "haha"});
```
