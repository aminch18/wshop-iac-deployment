# Infrastructure Deployment with Terraform

# Service Principal Creation
az ad sp create-for-rbac --name "{sp-name}" --sdk-auth --role contributor \
    --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group}
## Ideal 
## Infrastructure created:
    Az Resource Group
    Az CosmosDb Account
    Az CosmosDb SQL Database
    Az CosmosDb SQL Container
    Az Container Registry

## Workflows:
    Pull request: pr.yml
    Main: main.yml

## Documentation:
    In order to use this repostiory previously is recommended to create Service Principal in Azure in order to be able to do the Azure Login.

## Challenges:
    1. Modify the main.yml in order to be authenticated via Azure Storage Account Access Key.
        · Clone repository
        · Creation of Az Storage Account manually inside Azure.
        · Create new Git Hub Repository secret in order to add the requested environment variable related to the Az Blob Storage Access Key.
        · Modify pr.yml and main.yml files in order to authenticate