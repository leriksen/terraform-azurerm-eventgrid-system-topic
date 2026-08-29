provider "azurerm" {
  features {}
}

variables {
  location = "australiaeast"
}

run "setup_rg" {
  module {
    source = "./setup_rg"
  }
  command = apply

  variables {
    name     = "tftestegst"
    location = var.location
  }
}

run "setup_storage" {
  module {
    source = "./setup_storage"
  }
  command = apply

  variables {
    name                = "sttftestegstdev"
    resource_group_name = run.setup_rg.name
    location            = var.location
  }
}

# The identity is assigned by Azure at create time, so principal_id is only
# observable after a real apply — a plan-only test cannot prove this works.
run "system_topic_with_identity" {
  module {
    source = "./.."
  }
  command = apply

  variables {
    name                            = "evgt-tftest-egst-id"
    resource_group_name             = run.setup_rg.name
    location                        = var.location
    source_resource_id              = run.setup_storage.storage_account_id
    topic_type                      = "Microsoft.Storage.StorageAccounts"
    enable_system_assigned_identity = true
    tags                            = { env = "tftest" }
  }

  assert {
    condition     = output.name == "evgt-tftest-egst-id"
    error_message = "System topic name does not match the requested name."
  }

  assert {
    condition     = azurerm_eventgrid_system_topic.this.source_resource_id == run.setup_storage.storage_account_id
    error_message = "System topic source should be the storage account created by setup_storage."
  }

  assert {
    condition     = azurerm_eventgrid_system_topic.this.identity[0].type == "SystemAssigned"
    error_message = "Identity block should be present with type SystemAssigned."
  }

  assert {
    condition     = output.principal_id != null && output.principal_id != ""
    error_message = "SystemAssigned managed identity principal ID is not populated."
  }

  assert {
    condition     = output.metric_resource_id != ""
    error_message = "metric_resource_id should be populated after apply."
  }
}

# The dynamic identity block must emit nothing when the flag is off, leaving
# principal_id null rather than an empty-string placeholder.
run "system_topic_without_identity" {
  module {
    source = "./.."
  }
  command = apply

  variables {
    name                = "evgt-tftest-egst-noid"
    resource_group_name = run.setup_rg.name
    location            = var.location
    source_resource_id  = run.setup_storage.storage_account_id
    topic_type          = "Microsoft.Storage.StorageAccounts"
    tags                = { env = "tftest" }
  }

  assert {
    condition     = length(azurerm_eventgrid_system_topic.this.identity) == 0
    error_message = "No identity block should be emitted when enable_system_assigned_identity is false."
  }

  assert {
    condition     = output.principal_id == null
    error_message = "principal_id should be null when no managed identity is enabled."
  }

  assert {
    condition     = azurerm_eventgrid_system_topic.this.tags["env"] == "tftest"
    error_message = "Tags should be applied to the system topic."
  }
}
