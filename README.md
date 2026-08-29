<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
<!-- Developer Input -->
# terraform-azurerm-eventgrid-system-topic

Terraform module that creates an Azure EventGrid system topic for an existing
source resource, optionally with a SystemAssigned managed identity.

## Overview

A system topic represents events published by an Azure service — blob events
from a storage account, for example — and is the resource that event
subscriptions attach to. This module creates the topic explicitly, which is the
creation order Microsoft recommends: create the system topic first, then create
subscriptions on it. Subscriptions themselves are out of scope here; they are
handled by the companion `terraform-azurerm-eventgrid-system-topic-subscription`
module.

### Prerequisites

- An existing resource group to hold the system topic.
- An existing source resource to publish events, and its resource ID — a
  storage account, Service Bus namespace, IoT Hub and so on. The system topic
  cannot be created without one.
- The source resource must live in the **same Azure subscription** as the system
  topic. Event Grid will not create a topic in a different subscription from its
  event source.
- A `topic_type` matching the source resource, such as
  `Microsoft.Storage.StorageAccounts`. Azure validates this value and supports
  more types than the provider documents; `az eventgrid topic-type list` returns
  the current list.
- Permission to create `Microsoft.EventGrid/systemTopics`. If Azure Policy
  blocks that resource type, topic creation fails — events still flow, but the
  metrics and diagnostic capabilities that depend on the topic resource are
  unavailable.

### Features

- Creates a single `azurerm_eventgrid_system_topic` against an existing source
  resource.
- Optionally enables a SystemAssigned managed identity via
  `enable_system_assigned_identity`, for subscriptions that authenticate
  delivery or dead-lettering with the topic's own identity.
- Exposes the identity's `principal_id` as a scalar output for direct use in
  role assignments, alongside the full `identity` block.
- Exposes `metric_resource_id` for wiring the topic into Azure Monitor.
- Applies an arbitrary tag map.

### Limitations

- **One topic per source.** Event Grid allows only a single system topic per
  event source, so a second instance of this module pointed at the same
  `source_resource_id` will fail.
- **SystemAssigned identity only.** The resource also supports UserAssigned and
  the combined type; this module deliberately exposes only the SystemAssigned
  case. Use the underlying resource directly if you need a user-assigned
  identity.
- **Everything forces replacement.** `name`, `resource_group_name`, `location`,
  `source_resource_id` and `topic_type` are all ForceNew — changing any of them
  destroys and recreates the topic, taking its event subscriptions with it.
- **Location is not free.** The topic should sit in the same region as its event
  source. Global sources — Azure subscriptions, resource groups, Azure Maps —
  require `location` to be `Global` rather than a real region.
- **Not auto-deleted.** Because the topic is created explicitly rather than
  implicitly by an event subscription, it is not cleaned up when its last
  subscription is removed; its lifecycle is Terraform's.

### Documentation

- [System topics in Azure Event Grid](https://learn.microsoft.com/en-us/azure/event-grid/system-topics)
  — the authoritative reference for how system topics relate to their event
  subscriptions, covering the topic lifecycle, the one-topic-per-source rule,
  and how location and resource group are determined.

### Examples
For examples of how to use this module, please refer to the [examples](../examples) directory, or see the examples at the top of this page.

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_eventgrid_system_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_enable_system_assigned_identity"></a> [enable\_system\_assigned\_identity](#input\_enable\_system\_assigned\_identity) | When true, a SystemAssigned managed identity is enabled on the system topic. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the system topic will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the EventGrid system topic. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group in which to create the system topic. | `string` | n/a | yes |
| <a name="input_source_resource_id"></a> [source\_resource\_id](#input\_source\_resource\_id) | Resource ID of the resource that is the source of events (e.g. a Storage Account or Service Bus namespace). | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to the system topic. | `map(string)` | `{}` | no |
| <a name="input_topic_type"></a> [topic\_type](#input\_topic\_type) | EventGrid topic type corresponding to the source resource (e.g. 'Microsoft.Storage.StorageAccounts'). | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | Resource ID of the EventGrid system topic. |
| <a name="output_identity"></a> [identity](#output\_identity) | Identity block, including the principal\_id and tenant\_id when a managed identity is assigned. |
| <a name="output_metric_resource_id"></a> [metric\_resource\_id](#output\_metric\_resource\_id) | Azure-internal metric identifier (a GUID, not an ARM ID) for the system topic. |
| <a name="output_name"></a> [name](#output\_name) | Name of the EventGrid system topic. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | Principal ID of the SystemAssigned managed identity, or null when no identity is enabled. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->