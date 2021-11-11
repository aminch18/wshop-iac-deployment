variable "environments" {
    type        = list(string)
    description = "Simulates the different environments."
    default = ["dev", "stg", "prd"]
}

variable "resource_group_name" {
    type        = string
    description = "Azure Resource Group Names."
    default = "GithubActions-Trainning-Dev"
}

variable "base_sp_webapp_name" {
    type        = string
    description = "Azure Resource Group Name."
    default = "todoapi"
}

# variable "sku" {
#   description = "The sku for the appservice plans"
#   type = object({
#       tier = string
#       size = string
#   })
# }