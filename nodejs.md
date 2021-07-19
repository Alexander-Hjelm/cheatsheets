# Node js

<!--ts-->
* [Node js](nodejs.md#node-js)
   * [Hello world](nodejs.md#hello-world)
   * [command line](nodejs.md#command-line)
      * [Execute/run a program](nodejs.md#executerun-a-program)
   * [modules](nodejs.md#modules)
      * [export/import](nodejs.md#exportimport)

<!-- Added by: runner, at: Mon Jul 19 11:03:46 UTC 2021 -->

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
