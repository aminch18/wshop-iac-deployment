using Microsoft.EntityFrameworkCore;
using RestApi.TodosModule;
using RestApi.TodosModule.Persistence;

var builder = WebApplication.CreateBuilder(args);
builder.AddSerilog(); 
builder.Services.AddCors();
builder.AddSwagger();
builder.AddSqlPersistence();

var app = builder.Build();
var environment = app.Environment;

app
    .UseExceptionHandling(environment)
    .UseSwaggerEndpoints()
    .UseHttpsRedirection()
    .UseAppCors();

app.MapGet("/api/home", (HttpResponse res) =>
{
    return Results.Text("Minimal API :)");
});

app.MapGet("api/todo", async (http) =>
{
    var dbContext = http.RequestServices.GetService<TodosDbContext>();
    var Tasks = await dbContext.Tasks.ToListAsync();

    await http.Response.WriteAsJsonAsync(Tasks);
});

app.MapGet("api/todo/{id}", async (http) =>
{
    if (!http.Request.RouteValues.TryGetValue("id", out var id))
    {
        http.Response.StatusCode = 400;
        return;
    }

    var dbContext = http.RequestServices.GetService<TodosDbContext>();
    var todoItem = await dbContext.Tasks.FindAsync(int.Parse(id.ToString()));
    if (todoItem == null)
    {
        http.Response.StatusCode = 404;
        return;
    }

    await http.Response.WriteAsJsonAsync(todoItem);
});

app.MapPost("api/todo/create/{id}", async (http) =>
{
    var todoItem = await http.Request.ReadFromJsonAsync<Todo>();
    var dbContext = http.RequestServices.GetService<TodosDbContext>();
    dbContext.Tasks.Add(todoItem);
    await dbContext.SaveChangesAsync();
    http.Response.StatusCode = 204;
});

app.MapPut("api/todo/mark-as-completed/{id}", async (http) =>
{
    if (!http.Request.RouteValues.TryGetValue("id", out var id))
    {
        http.Response.StatusCode = 400;
        return;
    }

    var dbContext = http.RequestServices.GetService<TodosDbContext>();
    var todoItem = await dbContext.Tasks.FindAsync(int.Parse(id.ToString()));
    if (todoItem == null)
    {
        http.Response.StatusCode = 404;
        return;
    }

    var inputTodoItem = await http.Request.ReadFromJsonAsync<Todo>();
    todoItem.IsCompleted = inputTodoItem.IsCompleted;
    await dbContext.SaveChangesAsync();
    http.Response.StatusCode = 204;
});

app.MapDelete("api/todo/delete/{id}", async (http) =>
{
    if (!http.Request.RouteValues.TryGetValue("id", out var id))
    {
        http.Response.StatusCode = 400;
        return;
    }

    var dbContext = http.RequestServices.GetService<TodosDbContext>();
    var todoItem = await dbContext.Tasks.FindAsync(int.Parse(id.ToString()));
    if (todoItem == null)
    {
        http.Response.StatusCode = 404;
        return;
    }

    dbContext.Tasks.Remove(todoItem);
    await dbContext.SaveChangesAsync();

    http.Response.StatusCode = 204;
});

app.Run();
