# Infrastructure Deployment with Terraform

# Service Principal Creation
az ad sp create-for-rbac --name "{sp-name}" --sdk-auth --role contributor \
    --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group}
## Ideal 
## Infrastructure created:
    Az Resource Group
    Az Microsoft SQL Server
    Az SQL Database
    Az Container Registry

## Workflows:
    Pull request: pr.yml
    Main: main.yml

## Documentation:
    In order to use this repostiory previously is recommended to create Service Principal in Azure in order to be able to do the Azure Login.
    

## Challenge:
    Try to reproduce this using your cloned repository, in order to understand how to set repository secrets.
        · Clone repository
        · Just go to variables.tf and change the default values for the following terraform variables:
            · sql_server_name
            · key_vault_name
            · container_registry_name
        . Try to reproduce all that I've done it in the demo, and if you've got questions don't be shy 😊
        · When all the infrastructure is created successfully go to your databases by environment and open the Query Explorer with your user.
          and run this sql script:
          CREATE TABLE [Tasks] (
                [Department] nvarchar(max) NOT NULL,
                [Title] nvarchar(max) NULL,
                [IsCompleted] bit NOT NULL,
                CONSTRAINT [PK_Tasks] PRIMARY KEY ([Id])
          );