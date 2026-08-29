resource "azurerm_eventgrid_system_topic" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  source_resource_id  = var.source_resource_id
  topic_type          = var.topic_type

  dynamic "identity" {
    for_each = var.enable_system_assigned_identity ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  tags = var.tags
}
