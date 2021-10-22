data "azurerm_client_config" "current" {}

resource "azurerm_mssql_server" "server" {
  for_each                     = toset(var.environments)
  name                         = format("${var.sql_server_name}-%s", each.key)
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "pc-gh-admin"
  administrator_login_password = var.sql_server_admin_passwd
  minimum_tls_version          = "1.2"
  tags = {
    Customer      = "PlainConcepts",
    ExpirationDate = "27/10/2021"
    Owner         = "Team5"
    Project       = "Internal-Workshop"
    Environment   = "Dev"
  }

}

resource "azurerm_mssql_database" "db" {
  for_each       = azurerm_mssql_server.server
  name           = var.sql_database_name
  server_id      =  azurerm_mssql_server.server[each.key].id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 2
  sku_name       = "Basic"
  zone_redundant = false
  tags = {
    Customer      = "PlainConcepts",
    ExpirationDate = "27/10/2021"
    Owner         = "Team5"
    Project       = "Internal-Workshop"
    Environment   = "Dev"
  }
}

resource "azurerm_key_vault" "kv" {
  for_each                    = toset(var.environments)
  name                        = format("${var.key_vault_name}-%s", each.key)
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"
  tags = {
    Customer      = "PlainConcepts",
    ExpirationDate = "27/10/2021"
    Owner         = "Team5"
    Project       = "Internal-Workshop"
    Environment   = "Dev"
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "get",
      "create",
      "list",
      "update"
    ]

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete"
    ]

    storage_permissions = [
      "get",
    ]
  }
}

resource "azurerm_container_registry" "acr" {
  for_each            = toset(var.environments)
  name                = format("${var.container_registry_name}%s", each.key)
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = true
  tags = {
    Customer      = "PlainConcepts",
    ExpirationDate = "27/10/2021"
    Owner         = "Team5"
    Project       = "Internal-Workshop"
    Environment   = "Dev"
  }
}