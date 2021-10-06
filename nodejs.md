# Node js

<!--ts-->
* [Node js](nodejs.md#node-js)
   * [Hello world](nodejs.md#hello-world)
   * [command line](nodejs.md#command-line)
      * [Execute/run a program](nodejs.md#executerun-a-program)
   * [modules](nodejs.md#modules)
      * [export/import](nodejs.md#exportimport)
      * [export/import a single definiton](nodejs.md#exportimport-a-single-definiton)
   * [Files, IO](nodejs.md#files-io)
      * [Read file](nodejs.md#read-file)
         * [Read file, synchronously](nodejs.md#read-file-synchronously)
      * [Write file](nodejs.md#write-file)
      * [Read json file](nodejs.md#read-json-file)
      * [Parse xml file](nodejs.md#parse-xml-file)
      * [os.walk, iterate through files, subfolders](nodejs.md#oswalk-iterate-through-files-subfolders)
   * [Events](nodejs.md#events)
   * [Classes](nodejs.md#classes)
   * [Server application with Express](nodejs.md#server-application-with-express)
   * [Sample package.json](nodejs.md#sample-packagejson)

<!-- Added by: runner, at: Wed Oct  6 09:37:22 UTC 2021 -->

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

### export/import a single definiton

**Export**:
```bash
function log(s) {console.log(s)}

module.exports = log
```

**Import**:
```bash
const log = require('./logger.js')
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

#### Read file, synchronously
```typescript
var contents = fs.readFileSync(filename, 'utf8');
console.log(contents);
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

### Read json file
```typescript
const jsonOut = require("./sample.json");
```

### Parse xml file
```typescript
var contents = fs.readFileSync(fileName, 'utf8');
var convert = require('xml-js');
var xml = convert.xml2js(contents, {compact: true});

const accessElement = featuresXml["element"];
const accessArray = featuresXml["element"][0];
const accessAttribute = featuresXml["element"]["_attributes"]["name"];
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

## Classes
myclass.js:
```typescript
class MyClass {
  log(message) {
    console.log(message)
  }
}
module.exports = MyClass;
```

app.js:
```typescript
const MyClass = require("./myclass.js");
myClass = new MyClass();
```

## Server application with Express
```typescript
var express = require('express');
var app = express();

// This responds with "Hello World" on the homepage
app.get('/', function (req, res) {
   console.log("Got a GET request for the homepage");
   res.send('Hello GET');
})

// This responds a POST request for the homepage
app.post('/', function (req, res) {
   console.log("Got a POST request for the homepage");
   res.send('Hello POST');
})

// This responds a DELETE request for the /del_user page.
app.delete('/del_user', function (req, res) {
   console.log("Got a DELETE request for /del_user");
   res.send('Hello DELETE');
})

// This responds a GET request for the /list_user page.
app.get('/list_user', function (req, res) {
   console.log("Got a GET request for /list_user");
   res.send('Page Listing');
})

// This responds a GET request for abcd, abxcd, ab123cd, and so on
app.get('/ab*cd', function(req, res) {   
   console.log("Got a GET request for /ab*cd");
   res.send('Page Pattern Match');
})

// Default: http://127.0.0.1:8081
var server = app.listen(8081, function () {
   var host = server.address().address
   var port = server.address().port
   
   console.log("Example app listening at http://%s:%s", host, port)
})
```

## Sample package.json
```json
{
  "name": "docker_web_app",
  "version": "1.0.0",
  "description": "Node.js on Docker",
  "author": "First Last <first.last@example.com>",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.16.1"
  }
}
```
