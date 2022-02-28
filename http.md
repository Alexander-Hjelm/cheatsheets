# Http

## CORS

### Troubleshooting: blockedd by CORS Policy

```
Access to fetch at 'https://kompetenscitdev.dd.dll.se:4455/Ekonomi/Kostnadsfordelning/Data/ListReferences'
from origin 'null' has been blocked by CORS policy: Response to preflight request doesn't pass access 
control check: It does not have HTTP ok status.
```

Needs to be fixed at the server side, something like:

```
header := w.Header()
header.Add("Access-Control-Allow-Origin", "tfstest.dd.dll.se, tfs.dd.dll.se")
header.Add("Access-Control-Allow-Methods", "DELETE, POST, GET, OPTIONS")
header.Add("Access-Control-Allow-Headers", "Content-Type, Authorization, X-Requested-With")
if r.Method == "OPTIONS" {
    w.WriteHeader(http.StatusOK)
    return
}
```
