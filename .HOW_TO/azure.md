# Azure

## Static web apps

Sample staticwebapp.config.json:

```json
{
  "routes": [
    {
      "route": "/Decision.html",
      "allowedRoles": ["authenticated"]
    },
    {
      "route": "/test",
      "allowedRoles": ["authenticated"]
    },
    {
      "route": "/login",
      "redirect": "/.auth/login/aad"
    },
    {
      "route": "/*",
      "allowedRoles": ["authenticated"]
    },
  ],
  "navigationFallback": {
    "rewrite": "index.html"
  },
  "globalHeaders": {
    "content-security-policy": "default-src https: 'unsafe-eval' 'unsafe-inline'; object-src 'none'"
  },
  "mimeTypes": {
    ".json": "text/json"
  }
}
```
