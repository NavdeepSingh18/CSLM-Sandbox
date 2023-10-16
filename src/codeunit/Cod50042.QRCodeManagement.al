// // dotnet
// // {
// //     assembly(System)
// //     {
// //         type("System.Uri"; Uri1) { }
// //     }
// // }

// // dotnet
// // {
// //     assembly("System.Net.Http, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
// //     {
// //         type("System.Net.Http.HttpClient"; HttpClient1) { }
// //     }
// // }
// // dotnet
// // {
// //     assembly("System.Net.Http, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
// //     {
// //         type("System.Net.Http.HttpContent"; HttpContent) { }
// //     }
// // }
// // dotnet
// // {
// //     assembly("System.Net.Http, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
// //     {
// //         type("System.Net.Http.HttpResponseMessage"; HttpResponseMessage) { }
// //     }
// // }
// codeunit 50042 "QRCodeManagement"
// {
//     /// <summary> 
//     /// Description for CallRESTWebService.
//     /// </summary>
//     /// <param name="BaseUrl">Parameter of type Text.</param>
//     /// <param name="Method">Parameter of type Text.</param>
//     /// <param name="RestMethod">Parameter of type Text.</param>
//     /// <param name="VAR HttpContent1">Parameter of type DotNet HttpContent.</param>
//     /// <param name="VAR HttpResponseMessage1">Parameter of type DotNet HttpResponseMessage.</param>
//     procedure CallRESTWebService(BaseUrl: Text; Method: Text; RestMethod: Text; VAR HttpContent1: DotNet HttpContent; VAR HttpResponseMessage1: DotNet HttpResponseMessage);
//     Var
//         HttpClient: DotNet HttpClient1;
//         Uri: DotNet Uri1;

//     begin
//         HttpClient := HttpClient.HttpClient();
//         HttpClient.BaseAddress := Uri.Uri(BaseUrl);

//         CASE RestMethod OF
//             'GET':
//                 HttpResponseMessage1 := HttpClient.GetAsync(Method).Result();
//             'POST':
//                 HttpResponseMessage1 := HttpClient.PostAsync(Method, HttpContent1).Result();
//             'PUT':
//                 HttpResponseMessage1 := HttpClient.PutAsync(Method, HttpContent1).Result();
//             'DELETE':
//                 HttpResponseMessage1 := HttpClient.DeleteAsync(Method).Result();
//         END;
//         HttpResponseMessage1.EnsureSuccessStatusCode();
//     end;
// }

