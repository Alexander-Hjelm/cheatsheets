# Javascript

<!--ts-->
* [Javascript](javascript.md#javascript)
   * [Declaration](javascript.md#declaration)
      * [Declaration keywords](javascript.md#declaration-keywords)
      * [Import](javascript.md#import)
      * [Interface](javascript.md#interface)
      * [function](javascript.md#function)
   * [Arrays](javascript.md#arrays)
      * [forEach](javascript.md#foreach)
      * [map](javascript.md#map)
      * [filter](javascript.md#filter)
      * [2D arrays](javascript.md#2d-arrays)
      * [Slice](javascript.md#slice)
      * [Includes (contains)](javascript.md#includes-contains)
   * [Dictionaries](javascript.md#dictionaries)
      * [Iterating key/value pairs](javascript.md#iterating-keyvalue-pairs)
   * [Program logic](javascript.md#program-logic)
      * [for loop](javascript.md#for-loop)
      * [if/else](javascript.md#ifelse)
      * [switch](javascript.md#switch)
      * [use switch to return from a function](javascript.md#use-switch-to-return-from-a-function)
   * [String](javascript.md#string)
      * [String operations](javascript.md#string-operations)
         * [Split](javascript.md#split)
         * [Join](javascript.md#join)
         * [Substring](javascript.md#substring)
      * [Template string, format](javascript.md#template-string-format)
      * [Regex](javascript.md#regex)
   * [Asyncronous programing](javascript.md#asyncronous-programing)
      * [async function](javascript.md#async-function)
      * [await, then](javascript.md#await-then)
      * [async method](javascript.md#async-method)
   * [HTML components](javascript.md#html-components)
      * [React.Component](javascript.md#reactcomponent)
         * [render method](javascript.md#render-method)
         * [componentDidMount()](javascript.md#componentdidmount)
      * [Checkbox](javascript.md#checkbox)
      * [Span](javascript.md#span)
      * [Radio button group](javascript.md#radio-button-group)
      * [Text field](javascript.md#text-field)
      * [Date Picker](javascript.md#date-picker)
   * [Math](javascript.md#math)
      * [min, max](javascript.md#min-max)
      * [Round](javascript.md#round)
   * [Moment](javascript.md#moment)
   * [Window](javascript.md#window)
      * [get url for current page](javascript.md#get-url-for-current-page)
      * [Open a page in a new tab](javascript.md#open-a-page-in-a-new-tab)

<!-- Added by: runner, at: Thu Aug 19 07:37:24 UTC 2021 -->

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

## Arrays
```typescript
  let array: any[] = ['front',23,true,'back'];

  let len = array.length;
  let back = array.pop();     // Remove from back
  let front = array.shift();  // Remove from front
  
  // Remove at index
  let pos = 2;
  let removedItem = array.splice(pos, 1);
  
  array.push(back);          // Add to back
  array.unshift(front);      // Add to front
  // 3
  
  // Copy array
  let shallowCopy = array.slice()
```

### forEach

```typescript
array.forEach(element => {doStuff(element);});
```

### map
```typescript
array.map(element => {(element);});
```

### filter
```typescript
array.filter(element => {(element.property == someValue);});
```


### 2D arrays
```typescript
  let 2dArray: number[][] = [];
  2DArray.push([1,2,3,4]);
  2DArray[0][2];
  // 3
```

### Slice
Picks out a number of elements from an array into a new array
```typescript
my_array_sliced = my_array.slice(0,5)
```

### Includes (contains)
```typescript
const array1 = [1, 2, 3];

array1.includes(2)
// expected output: true
```

## Dictionaries
```typescript
var dict = {};

var dict = {
  FirstName: "Chris",
  "one": 1,
  1: "some value"
};

dict["one"] = 1;
```

### Iterating key/value pairs
```typescript
for(var key in dict) {
  var value = dict[key];

  // do something with "key" and "value" variables
}
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

## String

### String operations

#### Split
```typescript
let str = "1,2,3,4"
let splitted = str.split(",");
// [1,2,3,4]
```

#### Join
```typescript
my_str = my_array.join("/");
```

#### Substring
```typescript
str_sliced = my_str.substring(0, 10);
```

### Template string, format
```typescript
let sample = 100;
let formatted = `Total: ${sample}`
```

### Regex
```typescript
const regex = /[0-9]*\)$/g;
let matches = my_string.match(regex)[0];
// Returns an array of matches
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

### Checkbox
```typescript
<Checkbox
    label="User Story"
    checked={checkedFunc()}
    onChange={(_obj, item) => {
        this.doStuff(item);
    }}
/>
```

### Span
```typescript
<span className="frequency-picker-label">Value area filter</span>
```

### Radio button group
```typescript
<div className="radiobuttongroup">
    <label>
        <input type="radio" id="r1" name="rb1"
            checked={this.getChecked()}
            onChange={(event) => {
                this.doStuff("r1");
            }}
        />
        Radio Button 1
    </label>
    <label>
        <input type="radio" id="r2" name="rb2"
            checked={!this.getChecked()}
            onChange={(event) => {
                this.doStuff("r2");
            }}
        />
        Radio Button 2
    </label>
</div>
```

### Text field
```typescript
<TextField 
        className="texfield"
        value={this.getValue()}
        maxLength={50}
        onChange={(_obj, item) => {
            this.doStuff(item);
        }}
    />
```

### Date Picker
```typescript
<input type="date" 
        className="date-picker"
        placeholder="Select Date"
        value={this.getDate()}
        onChange={(event) => {
            this.doStuff(event.target.value);
        }}
    />
``` 

## Math

### min, max
```typescript
a = Math.max(a, b);
b = Math.min(a, b);
```

### Round
```typescript
Math.round(3.14159265359 * 100) / 100
```

## Moment
```typescript
import { Moment } from 'moment';
import moment = require('moment');

// From string
let str = "1995-12-31"
let dateA = moment(str,"YYYY-MM-DD");

// Compare moments
let momentsSameDay = moment(dateA).isSame(dateB, "Day");
let momentsBefore = moment(dateA).isBefore(dateB, "Day");
let momentsAfter = moment(dateA).isAfter(dateB, "Day");

// Add to moment
var changeddate = moment([2017, 2, 31]).add(5, 'hours');
```

## Window

### get url for current page
```typescript
let url = window.location.href;
```

### Open a page in a new tab
```typescript
window.open("https://wikipedia.org");
```
