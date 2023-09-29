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
      "allowedRoles": ["anonymous"]
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
    "responseOverrides": {
    "401": {
      "redirect": "/login.html",
      "statusCode": 302
    }
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

## Azure Blob Storage

### Troubleshooting

#### Access denied when uploading or downloading a blob

This issue can occur:

- In an azure pipeline
- In a PowerAutomate flow
- When connecting to the storage account in the terminal.

Solution:

In the Storage Account -> Access Control (IAM), Give the **service connection** or **AD Account** the role **Storage Blob Data Contributor**.