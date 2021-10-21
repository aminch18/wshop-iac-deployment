# output "resource_group_names" { 
#     value = toset([
#         for rg in azurerm_resource_group.rg : rg.name
#     ])
# }

output "resource_group_location" {
    value = var.location
}

output "key_vault_ids" {  
    value = toset([
        for kv in azurerm_key_vault.kv : kv.id
    ])
    sensitive = true
}

output "key_vault_uri" {    
    value = toset([
        for kv in azurerm_key_vault.kv : kv.vault_uri
    ])
    sensitive = true
}
output "sql_connection_strings" {
    value = toset([
        for server in azurerm_mssql_server.server : "Server=tcp:${server.fully_qualified_domain_name},1433;Initial Catalog=${var.sql_server_name};Persist Security Info=False;User ID=${server.administrator_login};Password=${server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    ])
    description = "Connection strings for the Azure SQL Database created by environment."
    sensitive = true
}

output "acr_server_url" {
    value = toset([
        for acr in azurerm_container_registry.acr : "https://${acr.login_server}"
    ])
}

output "acr_server_username" {    
    value = toset([
        for acr in azurerm_container_registry.acr : acr.admin_username
    ])
}

output "acr_server_psswd" {
    value = toset([
        for acr in azurerm_container_registry.acr : acr.admin_password
    ])
    sensitive = true
}