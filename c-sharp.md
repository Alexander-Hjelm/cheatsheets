# C#

<!--ts-->
* [C#](c-sharp.md#c)
   * [HTTP Client](c-sharp.md#http-client)
      * [Print response](c-sharp.md#print-response)
   * [Regex](c-sharp.md#regex)
   * [Newtonsoft.json](c-sharp.md#newtonsoftjson)
      * [Get string value from a JToken](c-sharp.md#get-string-value-from-a-jtoken)
      * [Replace a json token](c-sharp.md#replace-a-json-token)
   * [async](c-sharp.md#async)
      * [async WhenAll, await multiple async calls](c-sharp.md#async-whenall-await-multiple-async-calls)
   * [LibGit2Sharp](c-sharp.md#libgit2sharp)
      * [Create credentials](c-sharp.md#create-credentials)
      * [Clone a repository](c-sharp.md#clone-a-repository)
      * [Pull a repository](c-sharp.md#pull-a-repository)
      * [Pull feature branches](c-sharp.md#pull-feature-branches)

<!-- Added by: runner, at: Mon Feb 14 07:33:12 UTC 2022 -->

<!--te-->

## HTTP Client
```csharp
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

public enum HttpVerb
{
    GET,
    POST,
    PUT,
    DELETE,
    PATCH
}

namespace HttpUtils
{
    public class RestClient
    {
        public string EndPoint { get; set; }
        public HttpVerb Method { get; set; }
        public string ContentType { get; set; }
        public string PostData { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }

        private static readonly HttpClient httpClient = new HttpClient();

        public RestClient()
        {
            EndPoint = "";
            Method = HttpVerb.GET;
            ContentType = "application/json";
            PostData = "";
        }
        public RestClient(string endpoint)
        {
            EndPoint = endpoint;
            Method = HttpVerb.GET;
            ContentType = "application/json";
            PostData = "";
        }
        public RestClient(string endpoint, HttpVerb method, string userName, string password)
        {
            EndPoint = endpoint;
            Method = method;
            ContentType = "application/json";
            PostData = "";
            UserName = userName;
            Password = password;
        }

        public RestClient(string endpoint, HttpVerb method, string postData)
        {
            EndPoint = endpoint;
            Method = method;
            ContentType = "application/json";
            PostData = postData;
        }

        public async Task<string> MakeRequest()
        {
            return await MakeRequest(new Dictionary<string, string>(), "");
        }

        public async Task<string> MakeRequest(string data)
        {
            return await MakeRequest(new Dictionary<string, string>(), data);
        }

        public async Task<string> MakeRequest(Dictionary<string, string> parameters)
        {
            return await MakeRequest(new Dictionary<string, string>(), "");
        }

        public async Task<string> MakeRequest(Dictionary<string, string> parameters, string data)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(EndPoint);

            request.UserAgent = ".NET Foundation Repository Reporter";
            request.Accept = ContentType;
            request.Method = Method.ToString();

            var byteArray = ASCIIEncoding.ASCII.GetBytes(UserName+":"+Password);
            request.Headers.Add("Authorization", "Basic " +
                                              Convert.ToBase64String(byteArray));
              
            // Parameters
            StringBuilder strBuilder = new StringBuilder();
            foreach (string key in parameters.Keys)
            {
                strBuilder.Append(key + "='" + parameters[key] + "'&");
            }

            if(Method==HttpVerb.POST || Method == HttpVerb.PUT || Method == HttpVerb.PATCH)
            {
                request.ContentType = ContentType;
                using (var stream = new StreamWriter(request.GetRequestStream()))
                {
                    stream.Write(data);
                }

                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                Console.WriteLine(response);
            }

            using (var streamReader = new StreamReader(((HttpWebResponse)request.GetResponse()).GetResponseStream()))
            {
                var responseText = streamReader.ReadToEndAsync();
                //Now you have your response.
                //or false depending on information in the response
                return await responseText;
            }
        }
    }
}
```

### Print response
```csharp
var response = await client.PostAsync(createQueryRequest, content);
await _logger.LogInformationAsync(response.Content.ReadAsStringAsync().Result);
```

## Regex
```csharp
using System.Text.RegularExpressions;
var matches = Regex.Matches("MyStr12", @"\d+");
Regex.Matches("MyStr12", @"\d+").Count > 0
```

## Newtonsoft.json

### Get string value from a JToken

```csharp
string name = jToken["name"];
```

### Replace a json token

```csharp
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

JToken idToken = definitionJObject.SelectToken("variableGroupProjectReferences[0].projectReference.id");
idToken.Replace(project.Id);
```

## async

### async WhenAll, await multiple async calls

```csharp
await Task.WhenAll(items.Select(item => ProcessItem(wi)));
```

## LibGit2Sharp

### Create credentials

```csharp
private CredentialsHandler CreateCredentialsHandler(CredentialsDto credentials)
    => (url, usernameFromUrl, types) =>
        new UsernamePasswordCredentials()
        {
            Username = credentials.Username,
            Password = credentials.Password
        };
```

### Clone a repository

```csharp

var path = "C:\path\to\repo"
var url = "https:\\path.to.repo"

var credentialsHandler =
    CreateCredentialsHandler(credentials);

var cloneOptions = new CloneOptions
{
    CredentialsProvider = credentialsHandler,
    FetchOptions = new FetchOptions { TagFetchMode = TagFetchMode.All }
};

Repository.Clone(url, path, cloneOptions);
```

### Pull a repository

```csharp
public void PullRepository(string path, CredentialsDto credentials)
{
    try
    {
        var credentialsHandler =
            CreateCredentialsHandler(credentials);

        var options = new PullOptions
        {
            FetchOptions = new FetchOptions { CredentialsProvider = credentialsHandler, TagFetchMode = TagFetchMode.All }
        };
        using (var repo = new Repository(path))
        {
            var signature = new Signature(
                new Identity(name: credentials.Username, email: credentials.Username), DateTimeOffset.Now);

            Commands.Pull(repo, signature, options);
        }

    }
    catch (Exception e)
    {
        _logger.LogError($"Failed to pull latest changes with message: {e.Message}");
        throw;
    }
}
```

### Pull feature branches
```csharp
private void PullFeatureBranches(Repository repo, CredentialsDto credentials)
{
    var credentialsHandler =
        CreateCredentialsHandler(credentials);
    var options = new PullOptions
    {
        FetchOptions = new FetchOptions { CredentialsProvider = credentialsHandler, TagFetchMode = TagFetchMode.All }
    };
    var signature = new Signature(
        new Identity(name: credentials.Username, email: credentials.Username), DateTimeOffset.Now);

    Remote remote = repo.Network.Remotes["origin"];

    List<string> existingBranches = new List<string>();
    foreach (var branch in repo.Branches)
    {
        if (branch.CanonicalName.StartsWith("refs/heads/"))
        {
            existingBranches.Add(branch.CanonicalName.Replace("refs/heads/", ""));
        }
    }
    foreach (var branch in repo.Branches)
    {
        string shortName = branch.CanonicalName.Replace("refs/remotes/origin/", "");
        if (branch.CanonicalName.StartsWith("refs/remotes/origin/") && !existingBranches.Contains(shortName))
        {
            var localBranch = repo.Branches.Add(shortName, branch.Commits.Last());
            repo.Branches.Update(localBranch,
                b => b.Remote = remote.Name,
                b => b.UpstreamBranch = localBranch.CanonicalName);

            Commands.Checkout(repo, shortName);
            Commands.Pull(repo, signature, options);
            _logger.LogInformation("Pulled remote branch: " + branch.CanonicalName);
        }
    }
    // Finally, checkout main branch
    if(existingBranches.Count > 0)
        Commands.Checkout(repo, existingBranches.Last());
}
```

## Entity Framework Core

EFCore is an object-relational mapper.

Necessary dependencies for working with **SQL Server**:

* Microsoft.EntityFrameworkCore.Design
* Microsoft.EntityFrameworkCore.SqlServer

Necessary dependencies for working with **SQLite**:

* Microsoft.EntityFrameworkCore.Design
* Microsoft.EntityFrameworkCore.SqlServer

### Scaffolding

Build the relational objects from a database.

```bash
# Install EF tool
dotnet install global
dotnet tool install --global dotnet-ef

# Scaffolding
dotnet ef dbcontext scaffold "server=(localdb)\mssqgllocaldb;Database=Adventureworks2016;Trusted_Connection=True;" Microsoft.EntityFrameworkCore.SqlServer -d -c AwDBContext --context-dir EfStructures -o Entities
```
