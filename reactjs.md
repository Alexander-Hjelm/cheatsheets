# ReactJS

<!--ts-->
* [ReactJS](reactjs.md#reactjs)
   * [Declaration](reactjs.md#declaration)
      * [Declaration keywords](reactjs.md#declaration-keywords)
      * [Import](reactjs.md#import)
      * [Interface](reactjs.md#interface)
      * [function](reactjs.md#function)
   * [Program logic](reactjs.md#program-logic)
      * [for loop](reactjs.md#for-loop)
      * [if/else](reactjs.md#ifelse)
      * [switch](reactjs.md#switch)
      * [use switch to return from a function](reactjs.md#use-switch-to-return-from-a-function)
      * [forEach](reactjs.md#foreach)
      * [map](reactjs.md#map)
   * [String](reactjs.md#string)
      * [Split](reactjs.md#split)
   * [Asyncronous programing](reactjs.md#asyncronous-programing)
      * [async function](reactjs.md#async-function)
      * [await, then](reactjs.md#await-then)
      * [async method](reactjs.md#async-method)
   * [HTML components](reactjs.md#html-components)
      * [React.Component](reactjs.md#reactcomponent)
         * [render method](reactjs.md#render-method)
         * [componentDidMount()](reactjs.md#componentdidmount)
   * [Math](reactjs.md#math)
      * [min, max](reactjs.md#min-max)

<!-- Added by: runner, at: Tue May 25 13:34:29 UTC 2021 -->

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

### function
```typescript
public testFunction(a: string, b: boolean, c: number): any {
  doStuff();
```

## Program logic

### for loop

```typescript
for (let j = 1; j <= 5; j++) {
  // do stuff
}
```

### if/else

```typescript
if(a==b)
  doStuffA();
}
else if (a>b)
{
  doStuffB();
}
else
{
  doStuffC();
}
```

### switch
```typescript
switch (compValue) {

    case "a":
        doStuffA();
        break;
    case "b":
        doStuffB();
        break;
    case "c":
        doStuffC();
        break;
    default:
        doStuffD();
        break;
}
```

### use switch to return from a function
```typescript
func(item: Type): ReturnType {
    switch (item) {
        case "A":
            return 1;
        case "B":
            return 2;
        case "C":
            return 3;
    }
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

### await, then
There are 3 ways to exit from an async function

Either **await** the result:
```typescript
const result: any = await func ( param1, param2 );
```
Append the result to an array:
```typescript
array.push(... await func ( param1, param2 ));
```
Or use **then** to continue asyncronous execution
```typescript
func ( param1, param2 ).then(res => {
  doStuff(res);
});
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

## Math

### min, max
```typescript
a = Math.max(a, b);
b = Math.min(a, b);
```
