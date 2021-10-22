variable "environments" {
    type        = list(string)
    description = "Azure Resource Group Names."
    default = ["dev", "stg", "prd"]
}

variable "resource_group_name" {
    type        = string
    description = "Azure Resource Group Names."
    default = "GithubActions-Trainning-Dev"
}

variable "sql_server_admin_passwd"{
    type        = string
    description = "Azure Sql Server Name."
    default = "ppswd-4750590-es7"
}
variable "sql_server_name" {
    type        = string
    description = "Azure Sql Server Name."
    default = "sql-server-gh-ws-joan"
}

variable "sql_database_name" {
    type        = string
    description = "Azure Resource Group Name."
    default = "Tasks"
}

variable "key_vault_name" {
    type        = string
    description = "Azure Resource Group Name."
    default = "kv-gh-act-wshop-jj"
}

variable "location" {
    type        = string
    description = "Azure Resource Region Location"
    default = "westeurope"
}

variable "container_registry_name" {
    type        = string
    description = "Azure Container Registry Name"
    default = "acrwshopjoan"
}

# variable "environment" {
#   description = "The deployment environment"
#   type        = string
# }

# variable "ddos_plan_name" {
#     type        = string
#     description = "Azure Resource Group Name."
#     default = "ddospplan-gh-actions-wshop"
# }
# variable "virtual_network_name" {
#     type        = string
#     description = "Azure Resource Group Name."
#     default = "vn-gh-actions-wshop"
# }