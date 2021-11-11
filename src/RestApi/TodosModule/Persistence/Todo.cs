namespace RestApi.TodosModule;

public class Todo
{
    public int Id { get; set; }

    public string Department { get; set; }

    public string? Title { get; set; }
    public bool IsCompleted { get; set; }
}