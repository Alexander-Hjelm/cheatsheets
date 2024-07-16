# Jest Cheat Sheet

<!--ts-->
<!--te-->

Sure! Here's a comprehensive cheat sheet for using Jest, covering topics such as simple unit tests, class-based tests, setup and teardown, parameterized tests, mocking, and more.

## Installation

```sh
npm install --save-dev jest
```

## Running Tests

```sh
npx jest               # Run all tests
npx jest fileName      # Run tests in a specific file
npx jest -t "testName" # Run tests matching a specific name
npx jest --watch       # Watch files for changes and rerun tests
npx jest --coverage    # Generate test coverage reports
```

## Simple Unit Tests

```javascript
// sum.js
function sum(a, b) {
  return a + b;
}
module.exports = sum;

// sum.test.js
const sum = require('./sum');

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3);
});
```

## Class-Based Tests

```javascript
// calculator.js
class Calculator {
  add(a, b) {
    return a + b;
  }

  subtract(a, b) {
    return a - b;
  }
}
module.exports = Calculator;

// calculator.test.js
const Calculator = require('./calculator');

describe('Calculator', () => {
  let calculator;

  beforeEach(() => {
    calculator = new Calculator();
  });

  test('adds 1 + 2 to equal 3', () => {
    expect(calculator.add(1, 2)).toBe(3);
  });

  test('subtracts 5 - 2 to equal 3', () => {
    expect(calculator.subtract(5, 2)).toBe(3);
  });
});
```

## Setup and Teardown

### Using `beforeEach` and `afterEach`

```javascript
beforeEach(() => {
  // Setup code
});

afterEach(() => {
  // Teardown code
});

test('example test', () => {
  // Test code
});
```

### Using `beforeAll` and `afterAll`

```javascript
beforeAll(() => {
  // Setup code before all tests
});

afterAll(() => {
  // Teardown code after all tests
});

test('example test', () => {
  // Test code
});
```

## Parameterized Tests

```javascript
test.each([
  [1, 2, 3],
  [4, 5, 9],
  [10, 20, 30]
])('adds %i + %i to equal %i', (a, b, expected) => {
  expect(a + b).toBe(expected);
});
```

## Mocking

### Mocking Functions

```javascript
const myFunc = jest.fn();
myFunc.mockReturnValue('default');
myFunc.mockReturnValueOnce('first call').mockReturnValueOnce('second call');

test('mock function test', () => {
  expect(myFunc()).toBe('first call');
  expect(myFunc()).toBe('second call');
  expect(myFunc()).toBe('default');
});
```

### Mocking Modules

```javascript
// utils.js
function fetchData() {
  return 'real data';
}
module.exports = fetchData;

// utils.test.js
jest.mock('./utils');
const fetchData = require('./utils');

test('mock module test', () => {
  fetchData.mockReturnValue('mock data');
  expect(fetchData()).toBe('mock data');
});
```

### Mocking with `jest.spyOn`

```javascript
const utils = {
  fetchData: () => 'real data',
};

test('spyOn example', () => {
  const spy = jest.spyOn(utils, 'fetchData').mockReturnValue('mock data');
  expect(utils.fetchData()).toBe('mock data');
  spy.mockRestore(); // Restore the original implementation
});
```

## Async Tests

### Using Promises

```javascript
test('async test with promises', () => {
  return fetchData().then(data => {
    expect(data).toBe('data');
  });
});
```

### Using Async/Await

```javascript
test('async test with async/await', async () => {
  const data = await fetchData();
  expect(data).toBe('data');
});
```

## Testing with DOM (Jest and React Testing Library)

1. **Install dependencies:**

   ```sh
   npm install --save-dev @testing-library/react @testing-library/jest-dom
   ```

2. **Simple React component test:**

   ```javascript
   // MyComponent.js
   import React from 'react';

   function MyComponent() {
     return <div>Hello, World!</div>;
   }
   export default MyComponent;

   // MyComponent.test.js
   import React from 'react';
   import { render, screen } from '@testing-library/react';
   import '@testing-library/jest-dom/extend-expect';
   import MyComponent from './MyComponent';

   test('renders Hello, World!', () => {
     render(<MyComponent />);
     expect(screen.getByText('Hello, World!')).toBeInTheDocument();
   });
   ```

## Coverage Reports

```sh
npx jest --coverage
```

## Summary

- **Basic Testing**: `test` and `expect`
- **Class-Based Testing**: `describe`, `beforeEach`, and `afterEach`
- **Setup/Teardown**: `beforeEach`, `afterEach`, `beforeAll`, and `afterAll`
- **Parameterized Testing**: `test.each`
- **Mocking**: `jest.fn`, `jest.mock`, and `jest.spyOn`
- **Async Testing**: Using Promises or `async/await`
- **DOM Testing**: Using React Testing Library
- **Coverage Reports**: `--coverage`
