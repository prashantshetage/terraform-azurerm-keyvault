// Terraform will check when creating a Key Vault for a previous soft-deleted Key Vault and recover it if one exists
/* provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = var.purge_soft_delete_on_destroy
      recover_soft_deleted_key_vaults = var.recover_soft_deleted_key_vaults
    }
  }
} */


// Generate a random string to use in Key vault name
resource "random_string" "kv_name" {
  length  = 4
  special = false
  upper   = false
}


// Key Vault
resource "azurerm_key_vault" "keyvault" {
  name                = coalesce(var.keyvault_restore_name, local.keyvault_name)
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  soft_delete_enabled = var.soft_delete_enabled

  # This should allow scheduled purging of the key vault on destroy.
  purge_protection_enabled = var.purge_protection_enabled

  network_acls {
    # Default action to use when no rules match from ip_rules.
    default_action = var.nacl_default_action
    # Allows all azure services to acces the keyvault.
    bypass = var.az_svcs_bypass
    # The list of allowed ip addresses.
    ip_rules = var.nacl_allowed_ips
    # The list of allowed subnets
    virtual_network_subnet_ids = var.nacl_allowed_subnets
  }

  tags       = merge(var.resource_tags, var.deployment_tags)
  depends_on = [var.it_depends_on]

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

  timeouts {
    create = local.timeout_duration
    delete = local.timeout_duration
  }

}