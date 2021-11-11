locals {
  sql_connection_strings_map = zipmap(var.environments, tolist(data.terraform_remote_state.infra.outputs.sql_connection_strings))
}

resource "azurerm_app_service_plan" "appserviceplan" {
  for_each            = toset(var.environments)
  name                = "${var.base_sp_webapp_name}-sp-${each.key}"
  location            = data.terraform_remote_state.infra.outputs.resource_group_location
  resource_group_name = var.resource_group_name
  kind = "Linux"
  reserved = true # Mandatory for Linux plans
  sku {
    tier = "Basic"
    size = "B1"
  }
}

# Create an Azure Web App for Containers in that App Service Plan
resource "azurerm_app_service" "webapp" {
  for_each            =  azurerm_app_service_plan.appserviceplan
  name                = "${var.base_sp_webapp_name}-webapp-${each.key}"
  location            = data.terraform_remote_state.infra.outputs.resource_group_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan[each.key].id
  app_settings = {
      DataBaseConnectionString = "${local.sql_connection_strings_map[each.key]}"
      WEBSITE_WEBDEPLOY_USE_SCM = true
      AllowedHosts: "*",
  }

  site_config {
    linux_fx_version  = "DOTNET|6.0"
  }

  identity {
    type = "SystemAssigned"
  }
}