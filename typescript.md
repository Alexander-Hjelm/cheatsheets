# Typescript

## Troubleshooting

### Uncaught ReferenceError: exports is not defined

In your tsconfig.json, ensure that `"module": "commonjs",`

Add the following line before the script reference in your index.html:
```typescript
<script> var exports = {}; </script>
```
