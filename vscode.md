# Visual Studio Code

## Search with Regex groups

- Ctrl + F
- Click the .* button

Example, the following search/replace pattern:

```
([A-Za-z0-9_]*) \(([a-z., ]*)\)
| $1 | $2 |
```

Example:
```
AM12-PDP (.js, .js.map, .tiff, .svg, etc...)
| AM12-PDP | .js, .js.map, .tiff, .svg, etc... |
```
