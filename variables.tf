variable "name" {
  type        = string
  description = "Name of the EventGrid system topic."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group in which to create the system topic."
}

variable "location" {
  type        = string
  description = "Azure region where the system topic will be created."
}

variable "source_arm_resource_id" {
  type        = string
  description = "ARM resource ID of the resource that is the source of events (e.g. a Storage Account or Service Bus namespace)."
}

variable "topic_type" {
  type        = string
  description = "EventGrid topic type corresponding to the source resource (e.g. 'Microsoft.Storage.StorageAccounts')."
}

variable "system_assigned_identity_enabled" {
  type        = bool
  default     = false
  description = "When true, a SystemAssigned managed identity is enabled on the system topic."
}


variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of tags to apply to the system topic."
}
