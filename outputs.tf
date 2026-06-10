output "id" {
  value       = azurerm_eventgrid_system_topic.this.id
  description = "Resource ID of the EventGrid system topic."
}

output "name" {
  value       = azurerm_eventgrid_system_topic.this.name
  description = "Name of the EventGrid system topic."
}

output "metric_arm_resource_id" {
  value       = azurerm_eventgrid_system_topic.this.metric_arm_resource_id
  description = "ARM resource ID used for Azure Monitor metrics."
}

output "identity" {
  value       = azurerm_eventgrid_system_topic.this.identity
  description = "Identity block, including the principal_id and tenant_id when a managed identity is assigned."
}
