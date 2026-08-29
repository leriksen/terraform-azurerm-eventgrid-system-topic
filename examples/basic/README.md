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


## Providers

No providers.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | Azure region for the system topic. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group in which to create the system topic. | `string` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | Resource ID of the storage account that is the source of events. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | Resource ID of the EventGrid system topic. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | Principal ID of the system topic's managed identity. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->