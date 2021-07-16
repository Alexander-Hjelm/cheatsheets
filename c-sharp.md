# C#

<!--ts-->
* [C#](c-sharp.md#c)
   * [HTTP Client](c-sharp.md#http-client)

<!-- Added by: runner, at: Fri Jul 16 10:53:29 UTC 2021 -->

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
