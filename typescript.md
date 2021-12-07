# Typescript

<!--ts-->
* [Typescript](typescript.md#typescript)
   * [Troubleshooting](typescript.md#troubleshooting)
      * [Uncaught ReferenceError: exports is not defined](typescript.md#uncaught-referenceerror-exports-is-not-defined)
   * [cannot find module [module] or its corresponding type declarations](typescript.md#cannot-find-module-module-or-its-corresponding-type-declarations)
   * [IPromise&lt;any&gt; is not assignable to type Promise&lt;any&gt;](typescript.md#ipromiseany-is-not-assignable-to-type-promiseany)

<!-- Added by: runner, at: Tue Dec  7 11:20:40 UTC 2021 -->

<!--te-->

## Troubleshooting

### Uncaught ReferenceError: exports is not defined

In your tsconfig.json, ensure that `"module": "commonjs",`

Add the following line before the script reference in your index.html:
```typescript
<script> var exports = {}; </script>
```
## cannot find module [module] or its corresponding type declarations

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

## IPromise\<any\> is not assignable to type Promise\<any\>

Wrap the IPromise in a Promise

```
return deferred.promise;
->
return Promise.resolve(deferred.promise);
