output "id" {
  value       = module.eventgrid_system_topic.id
  description = "Resource ID of the EventGrid system topic."
}

output "principal_id" {
  value       = module.eventgrid_system_topic.principal_id
  description = "Principal ID of the system topic's managed identity."
}
