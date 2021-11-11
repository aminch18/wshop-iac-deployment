# Azure App Service Deployment with Terraform

## Infrastructure created:
    Az App Service
    2 Az App Service Slots

# Service Principal Creation
az ad sp create-for-rbac --name "{sp-name}" --sdk-auth --role contributor \
    --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group}

## Workflows:
    Pull request: pr.yml
    Main: main.yml

## Documentation:
  In order to use this repostiory previously is recommended to create Service Principal in Azure in order to be able to do the Azure Login.
  Links:
    · Github Actions Market Place: https://github.com/marketplace?type=actions
    · Github Workflows Documentation: 

## Challenges:
  ##### Previous steps in order to be able to create your own infrastructure
        1. Clone repository
        2. Go to GithubActions-Trainning-Tf-Dev
        3. Enter to tfbackend024356d Storage Account
        4. Enter to tf-backend Storage Blob Container
        5. Add your custom tfstate doing this => {username}-application.tfstate (I recommend to use Storage Explorer in order to change the file content type)
        6. Upload your personal tfstate file.
        7. Change the backend file, updating the key field with the name of your personal tfstate file.
        
        After these steps you should be able to use the pipeline in order to create your web app infrastructure, be careful because previously you should deploy the common infrastructure, in order to use the remote state to know the required values of our common infrastructure, for example the Sql Data Base connection string.

  #### Challenge: Modify the main.yml in order to deploy our app service using the Az Container Registry.
        1. Try to reproduce the steps in the demo.
        2. Using as reference the wshop-iac-deployment repository, try to write a workflow named kill.yml in this repository.
        Extra challenge:
            1.Find how to do login on our ACR using github actions.
            2. Build and push the new image to yout AZ Container Registry.
            3. Use the azure/webapps-deploy@v2 action using the image created for each step and push it. 
                If you need to modify the app settings, I recommend to do it directly via the portal, but if you know how to do it with terraform, do it! 😊

## Things you will need for terraform:

#### Personal TfState
{
    "version": 3,
    "serial": 1,
    "lineage": "7d2ef47a-92dd-c78e-7ebf-0d1eee9b4c92",
    "backend": {
        "type": "azurerm",
        "config": {
            "access_key": null,
            "client_certificate_password": null,
            "client_certificate_path": null,
            "client_id": null,
            "client_secret": null,
            "container_name": "tf-backend",
            "endpoint": null,
            "environment": null,
            "key": "{personal-tfstate-file-name}", // ONLY NEED TO CHANGE THIS VALUE
            "metadata_host": null,
            "msi_endpoint": null,
            "resource_group_name": "GithubActions-Trainning-Tf-Dev",
            "sas_token": null,
            "snapshot": null,
            "storage_account_name": "tfbackend024356d",
            "subscription_id": null,
            "tenant_id": null,
            "use_azuread_auth": null,
            "use_msi": null
        },
        "modules": [
            {
                "path": [
                    "root"
                ],
                "outputs": {},
                "resources": {},
                "depends_on": []
            }
        ]
    }
