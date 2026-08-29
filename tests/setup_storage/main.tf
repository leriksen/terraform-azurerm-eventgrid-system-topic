# Event source for the system topic under test. A system topic cannot be
# created without a real source resource, so the module needs one applied
# before it can run.
resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
