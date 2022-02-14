# Typescript

<!--ts-->
* [Typescript](typescript.md#typescript)
   * [Troubleshooting](typescript.md#troubleshooting)
      * [Uncaught ReferenceError: exports is not defined](typescript.md#uncaught-referenceerror-exports-is-not-defined)
      * [cannot find module [module] or its corresponding type declarations](typescript.md#cannot-find-module-module-or-its-corresponding-type-declarations)
      * [IPromise&lt;any&gt; is not assignable to type Promise&lt;any&gt;](typescript.md#ipromiseany-is-not-assignable-to-type-promiseany)
      * [Issue with require, define, XXX is not defined etc](typescript.md#issue-with-require-define-xxx-is-not-defined-etc)
      * [define is not defined](typescript.md#define-is-not-defined)

<!-- Added by: runner, at: Mon Feb 14 07:33:19 UTC 2022 -->

<!--te-->

## Troubleshooting

### Uncaught ReferenceError: exports is not defined

In your tsconfig.json, ensure that `"module": "commonjs",`

Add the following line before the script reference in your index.html:
```typescript
<script> var exports = {}; </script>
```
### cannot find module [module] or its corresponding type declarations

1. Install the package by adding it as a dependency to node.js and running `npm install`.
1. Add its corresponding type to your tsconfig.json:

```json
{
    "compilerOptions": {
    ...
        "types": [
            "vss-web-extension-sdk"
        ]
    },   
    "include": [
        "src/**/*.tsx"
    ]    
}
```

### IPromise\<any\> is not assignable to type Promise\<any\>

Wrap the IPromise in a Promise

```
return deferred.promise;
->
return Promise.resolve(deferred.promise);
```

### Issue with require, define, XXX is not defined etc

1. Check the typescript version
2. Check other dependencies
3. Check tsconfig
4. Add logging in the js file to determine which import is causing the issue.

### define is not defined
```
npm install amd-loader
```
Then add `require("amd-loader")` to the top of the .ts file.
