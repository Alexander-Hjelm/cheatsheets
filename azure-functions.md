# Azure Functions
<!--ts-->
<!--te-->

## HTTP GET integration

```csharp
#r "Newtonsoft.Json"

using System;
using System.Net;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;

public static async Task<IActionResult> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");
    string response = await MakeConsumptionAPIRequest();
    return new OkObjectResult(response);
}

public static async Task<string> MakeConsumptionAPIRequest() {
    string result = "";
    using (var client = new HttpClient())
    {
        client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", "d2b86a9f46a9491590e8cacd4d905641");
        var response = await client.GetAsync("https://alexander-demo-apim-consumption.azure-api.net/conf/session/100");
        result = await response.Content.ReadAsStringAsync();
    }
    return result;
}
```

### HTTP POST integration

```csharp
    #r "Newtonsoft.Json"

    using System;
    using System.Net;
    using System.Text;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Primitives;
    using Newtonsoft.Json;

    public static async Task<IActionResult> Run(HttpRequest req, ILogger log)
    {
        log.LogInformation("C# HTTP trigger function processed a request.");
        string nameParam = req.Query["nameParam"];
        string response = await MakeConsumptionAPIRequest(nameParam);
        return new OkObjectResult(response);
    }

    public static async Task<string> MakeConsumptionAPIRequest(string message) {
        string result = "";
        using (var client = new HttpClient())
        {
            var requestData = new StringContent("{'text':'"+message+"'}", Encoding.UTF8, "application/json");
            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", "d2b86a9f46a9491590e8cacd4d905641");
            var response = await client.PostAsync("https://alexander-demo-apim-consumption.azure-api.net/conf/session", requestData);
            result = await response.Content.ReadAsStringAsync();
            
        }
        return result;
    }
```

## Azure functions app that consumes a keyvault secret

```csharp
/*
Add the Microsoft.Azure dependencies by creating a new file: "project.json":

{
    "frameworks" : {
        "net46" : {
            "dependencies" : {
                "Microsoft.Azure.KeyVault": "2.3.2",
                "Microsoft Azure. Services. AppAuthentication" : "1.0.0-preview",
                "Microsoft. Rest.clientRuntime. Azure" : "3.0.0.0"
            }
        }
    }
}

Test the function using the following request and replace the “Secret” with the secret name which was created earlier

{

“Secret”: “Integration-Team-Blog”

}
*/

#r "Newtonsoft.Json"

using System.Net;
using System.Configuration;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.Azure.KeyVault;
using Microsoft.Azure.KeyVault.Models;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using Newtonsoft.Json;
using System.Text;

public static async Task Run(HttpRequestMessage req, TraceWriter log)
{
    log.Info(“C# HTTP trigger function processed a request.”);

    SecretRequest secretRequest = await req.Content.ReadAsAsync();

    if(string.IsNullOrEmpty(secretRequest.Secret))
        return req.CreateResponse(HttpStatusCode.BadRequest, “Request does not contain a valid Secret.”);

    log.Info($”GetKeyVaultSecret request received for secret {secretRequest.Secret}”);

    var serviceTokenProvider = new AzureServiceTokenProvider();

    var keyVaultClient = new KeyVaultClient(new KeyVaultClient.AuthenticationCallback(serviceTokenProvider.KeyVaultTokenCallback));

    var secretUri = SecretUri(secretRequest.Secret);
    log.Info($”Key Vault URI {secretUri} generated”);
    SecretBundle secretValue;
    try
    {
        secretValue = await keyVaultClient.GetSecretAsync(secretUri);
    }
    catch(KeyVaultErrorException kex)
    {
        return req.CreateResponse(HttpStatusCode.NotFound, $”{kex.Message}”);
    }
    log.Info(“Secret Value retrieved from KeyVault.”);

    var secretResponse = new SecretResponse {Secret = secretRequest.Secret, Value = secretValue.Value};

    return new HttpResponseMessage(HttpStatusCode.OK) {
    Content = new StringContent(JsonConvert.SerializeObject(secretResponse), Encoding.UTF8, “application/json”)};

}

public class SecretRequest
{
    public string Secret {get;set;}
}

public class SecretResponse
{
    public string Secret {get; set;}
    public string Value {get; set;}
}

public static string SecretUri(string secret)
{
    return $”{ConfigurationManager.AppSettings[“KeyVaultUri”]}/Secrets/{secret}”;
}

```
