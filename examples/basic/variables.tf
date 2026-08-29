variable "resource_group_name" {
  type        = string
  description = "Resource group in which to create the system topic."
}

variable "location" {
  type        = string
  description = "Azure region for the system topic."
}

variable "storage_account_id" {
  type        = string
  description = "Resource ID of the storage account that is the source of events."
}
