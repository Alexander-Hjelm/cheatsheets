# npm

## npm proxy config

Run the following in a powershell prompt:

```powershell
# npm config
npm config set registry http://nexus.se:8080/repository/npm-public
npm config set strict-ssl false

# Env vars
$env:HTTP_PROXY = 'http://klientproxy.se:8080'
$env:NO_PROXY = 'nexus.se'
$env:NODE_TLS_REJECT_UNAUTHORIZED = 0
```

## Detect unused npm packages

In the same directory as the **package.json**:

```bash
npm install -g depcheck 
depcheck
```
