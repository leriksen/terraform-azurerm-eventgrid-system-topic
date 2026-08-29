<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Description
Basic example of how to create an event grid system topic



## Example Usage
Basic usage of this module is as follows:




  ### main.tf
  ```hcl
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
  ```
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->