module "eventgrid_system_topic" {
  source = "../../"

  name                = "evgt-example"
  resource_group_name = var.resource_group_name
  location            = var.location
  source_resource_id  = var.storage_account_id
  topic_type          = "Microsoft.Storage.StorageAccounts"

  enable_system_assigned_identity = true

  tags = { env = "example" }
}
