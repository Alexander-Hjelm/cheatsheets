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

### Troubleshooting

#### CSP header

Error message:
```
VM290:1 Refused to connect to 'http://fulltextsearch.norwayeast.azurecontainer.io/?search_str=a&eferer_url=https://zealous-river-0de318e03.azurestaticapps.net' because it violates the following Content Security Policy directive: "default-src https: 'unsafe-eval' 'unsafe-inline'". Note that 'connect-src' was not explicitly set, so 'default-src' is used as a fallback.
```

**Solution**: Add the origin to the *globalHeaders.content-security-policy* field in staticwebapp.config.json
