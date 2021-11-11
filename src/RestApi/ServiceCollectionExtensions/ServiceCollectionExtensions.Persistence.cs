namespace Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using RestApi.TodosModule.Persistence;

public static partial class ServiceCollectionExtensions
{
    public static WebApplicationBuilder AddSqlPersistence(this WebApplicationBuilder builder)
    {
        builder.Services.AddTasksContext(builder.Configuration);

        return builder;
    }

    private static IServiceCollection AddTasksContext(this IServiceCollection services, IConfiguration configuration)
        => services.AddDbContext<TodosDbContext>(options => options.UseSqlServer(configuration.GetValue<string>("DataBaseConnectionString")));
}
