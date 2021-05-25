# ReactJS

<!--ts-->
<!--te-->

## Declaration

### Declaration keywords
```typescript
var a = 0;    // variable
const b = 0;  // constant
let c = 0;    // implicit
```

### Import
```typescript
import * as React from "react";               // Import everything into a single object
import { libA, libB, libC } from "libName";   // Import selected libraries directly
import { libName } from "../Common";          // Import directly from a file in the repository
```

### Interface
```typescript
interface ITest {
  a: string;
  b: number;
  c: string[];
}
```


## Program logic

### for loop

```typescript
for (let j = 1; j <= 5; j++) {
  // do stuff
}
```

### forEach

```typescript
array.forEach(element => {doStuff(element);});
```

### map
```typescript
array.map(element => {(element);});
```

## String

### Split
```typescript
let str = "1,2,3,4"
let splitted = str.split(",");
// [1,2,3,4]
```

## Asyncronous programing

### async function
```typescript
private async loadTable() {
  return doStuff();   // Generates an IPromise
}
```

### await
There are 2 ways to exit from an async function

Either **await** the result:
```typescript
const result: any = await func { param1, param2 });
```
Append the result to an array:
```typescript
array.push(... await func { param1, param2 });
```

### async method

## HTML components

### React.Component

#### render method

```typescript
public render(): JSX.Element {
  return (
    <div></div>
  }
}
```

#### componentDidMount()

```typescript
public componentDidMount() {
  SDK.init().then(() => {
    this.registerEvents();
  });
  this.registerInputEvents();
}
```
