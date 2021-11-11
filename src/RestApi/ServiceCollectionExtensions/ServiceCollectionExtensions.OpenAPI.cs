namespace Microsoft.Extensions.DependencyInjection;

using Microsoft.OpenApi.Models;
using RestApi;

public static partial class ServiceCollectionExtensions
{
    public static WebApplicationBuilder AddSwagger(this WebApplicationBuilder builder)
    {
        builder.Services.AddSwagger();

        return builder;
    }

    public static IServiceCollection AddSwagger(this IServiceCollection services)
    {
        services.AddEndpointsApiExplorer();
        services.AddSwaggerGen(c =>
        {
            c.SwaggerDoc("v1", new OpenApiInfo()
            {
                Description = "Todos Minimal API Demo",
                Title = "Todos Minimal API Demo",
                Version = "v1",
                Contact = new OpenApiContact()
                {
                    Name = "Amin Chouaibi",
                    Url = new Uri("https://github.com/aminch18")
                }
            });
            c.DocumentFilter<CustomDocumentFilter>();
        });

        return services;
    }
}
