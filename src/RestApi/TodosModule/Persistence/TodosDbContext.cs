using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace RestApi.TodosModule.Persistence;

public class TodosDbContext : DbContext
{
    public TodosDbContext(DbContextOptions<TodosDbContext> options)
        : base(options)
    {

    }

    public DbSet<Todo> Tasks { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
        base.OnModelCreating(modelBuilder);
    }
}