output "id" {
  value       = azurerm_eventgrid_system_topic.this.id
  description = "Resource ID of the EventGrid system topic."
}

output "name" {
  value       = azurerm_eventgrid_system_topic.this.name
  description = "Name of the EventGrid system topic."
}

output "metric_resource_id" {
  value       = azurerm_eventgrid_system_topic.this.metric_resource_id
  description = "Azure-internal metric identifier (a GUID, not an ARM ID) for the system topic."
}

output "identity" {
  value       = azurerm_eventgrid_system_topic.this.identity
  description = "Identity block, including the principal_id and tenant_id when a managed identity is assigned."
}

output "principal_id" {
  value       = try(azurerm_eventgrid_system_topic.this.identity[0].principal_id, null)
  description = "Principal ID of the SystemAssigned managed identity, or null when no identity is enabled."
}
