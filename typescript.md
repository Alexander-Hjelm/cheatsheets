# Typescript

## Troubleshooting

### Uncaught ReferenceError: exports is not defined

Add the following line before the script reference in your index.html:
```typescript
<script> var exports = {}; </script>
```
