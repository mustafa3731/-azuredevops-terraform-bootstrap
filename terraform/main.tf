# Random suffix to keep Storage Account name globally unique
resource "random_string" "suffix" {
  length  = 4
  upper   = false
  lower   = true
  number  = true
  special = false
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}"
  location = var.location
  tags     = var.tags
}

# Storage Account
# SA name must be 3-24 chars, lowercase letters/numbers only, globally unique
locals {
  sa_name_clean = regexreplace(var.project_name, "[^a-z0-9]", "")
  sa_name       = substr("st${local.sa_name_clean}${random_string.suffix.result}", 0, 24)
}

resource "azurerm_storage_account" "sa" {
  name                     = local.sa_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false
  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"

  tags = var.tags
}
