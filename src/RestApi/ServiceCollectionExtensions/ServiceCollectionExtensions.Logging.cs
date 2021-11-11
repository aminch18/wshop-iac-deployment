namespace Microsoft.Extensions.DependencyInjection;

using Microsoft.AspNetCore.Builder;
using Serilog;
using Serilog.Events;
using Serilog.Sinks.SpectreConsole;

public static partial class ServiceCollectionExtensions
{

    public static WebApplicationBuilder AddSerilog(this WebApplicationBuilder builder)
    {
        string outputTemplate = "{Timestamp:HH:mm:ss} [{Level:u4}] {Message:lj}{NewLine}{Exception}";
        Log.Logger = new LoggerConfiguration()
                            .MinimumLevel.Debug()
                            .WriteTo.SpectreConsole(outputTemplate: outputTemplate, minLevel: LogEventLevel.Information)
                            .CreateLogger();

        builder.Host.UseSerilog();

        return builder;
    }
}
