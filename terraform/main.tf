data "azurerm_client_config" "current" {}

locals {
  base_cosmos_db_account_name = "db-gh-actions-wshop"
  vn_adress_space   = ["10.0.0.0/16"]
  vn_dns_servers    = ["10.0.0.4", "10.0.0.5"]
  vn_enviroment_tag = "Production"
}

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




##Limited due to the Service Principal restrictions

# resource "azurerm_resource_group" "rg" {
#   for_each = toset(var.resource_group_names)
#   name     = each.key
#   location = var.location
# }

# resource "azurerm_network_ddos_protection_plan" "ddos" {
#   count               = local.is_high_availability ? 1 : 0
#   name                = var.ddos_plan_name
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# resource "azurerm_virtual_network" "vn" {
#   count               = local.is_high_availability ? 1 : 0
#   name                = var.virtual_network_name
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   address_space       = local.vn_adress_space
#   dns_servers         = local.vn_dns_servers
  
#   # dynamic "ddos_protection_plan" {
#   #   for_each = local.is_high_availability == true ? range(1) : range(0)
#   #   iterator = v
#   #   content {
#   #     id = azurerm_network_ddos_protection_plan.ddos.id
#   #     enable = true
#   #   }
#   # }

#   tags = {
#     environment = local.vn_enviroment_tag
#   }
# # }

// Policy restrictions from Plain tenant
# resource "azurerm_cosmosdb_account" "db" {
#   for_each            = toset(var.environments)
#   name                = "${local.base_cosmos_db_account_name}-${each.key}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   offer_type          = "Standard"
#   kind                = "GlobalDocumentDB"
#   enable_automatic_failover = true

#   capabilities {
#     name = "EnableAggregationPipeline"
#   }

#   capabilities {
#     name = "mongoEnableDocLevelTTL"
#   }

#   capabilities {
#     name = "MongoDBv3.4"
#   }

#   consistency_policy {
#     consistency_level       = "BoundedStaleness"
#     max_interval_in_seconds = 300
#     max_staleness_prefix    = 100000
#   }

#   geo_location {
#     location          = var.failover_location
#     failover_priority = 1
#   }

#   geo_location {
#     location          = var.location
#     failover_priority = 0
#   }
# }

# resource "azurerm_cosmosdb_sql_database" "sql-db" {
#   for_each            = toset(var.environments)
#   name                = var.cosmosdb_database_name
#   resource_group_name = var.resource_group_name
#   account_name        = "${local.base_cosmos_db_account_name}-${each.key}"
#   autoscale_settings {
#     max_throughput = 4000
#   }
# }

# resource "azurerm_cosmosdb_sql_container" "container" {
#   for_each              = toset(var.environments)
#   name                  = var.cosmosdb_tasks_container_name
#   resource_group_name   = var.resource_group_name
#   account_name          = "${local.base_cosmos_db_account_name}-${each.key}"
#   database_name         = var.cosmosdb_database_name
#   partition_key_path    = "/_pk"
#   partition_key_version = 1

#   indexing_policy {
#     indexing_mode = "Consistent"

#     included_path {
#       path = "/*"
#     }

#     excluded_path {
#       path = "/excluded/?"
#     }
#   }
# }


