using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace RestApi
{
    public class CustomDocumentFilter : IDocumentFilter
    {
        public const string GET_SINGLE = "api/todo/{id}";
        public const string GET_ALL = "api/todo";
        public const string POST = "api/todo/create/{id}";
        public const string PUT = "api/todo/mark-as-completed/{id}";
        public const string DELETE = "api/todo/delete/{id}";
        public void Apply(OpenApiDocument openApiDocument, DocumentFilterContext context)
        {
            // define operation
            var operation = new OpenApiOperation
            {
                Summary = "Returns version information"
            };
            // assign tag
            operation.Tags.Add(new OpenApiTag { Name = "Version" });

            // create response properties
            var properties = new Dictionary<string, OpenApiSchema>
            {
                { "Version", new OpenApiSchema() { Type = "string" } }
            };

            // create response
            var response = new OpenApiResponse
            {
                Description = "Success"
            };

            // add response type
            response.Content.Add("application/json", new OpenApiMediaType
            {
                Schema = new OpenApiSchema
                {
                    Type = "object",
                    AdditionalPropertiesAllowed = true,
                    Properties = properties,
                }
            });

            operation.Responses.Add("200", response);
            operation.Responses.Add("204", response);
            operation.Responses.Add("404", response);
            operation.Responses.Add("400", response);

            // create path item
            var pathItem = new OpenApiPathItem();
            var pathItem2 = new OpenApiPathItem();
            var pathItem3 = new OpenApiPathItem();
            var pathItem4 = new OpenApiPathItem();
            var pathItem5 = new OpenApiPathItem();

            // add operation to the path
            pathItem.AddOperation(OperationType.Get, operation);
            pathItem2.AddOperation(OperationType.Get, operation);
            pathItem3.AddOperation(OperationType.Post, operation);
            pathItem4.AddOperation(OperationType.Put, operation);
            pathItem5.AddOperation(OperationType.Delete, operation);
            // finally add the path to document
            openApiDocument?.Paths.Add(GET_ALL, pathItem);
            openApiDocument?.Paths.Add(GET_SINGLE, pathItem2);
            openApiDocument?.Paths.Add(POST, pathItem3);
            openApiDocument?.Paths.Add(PUT, pathItem4);
            openApiDocument?.Paths.Add(DELETE, pathItem5);
        }
    }
}
