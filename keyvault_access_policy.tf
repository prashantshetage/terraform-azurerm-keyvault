// Sets up default access policies for Key Vault
//**********************************************************************************************
resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions         = var.key_permissions_full
  secret_permissions      = var.secret_permissions_full
  certificate_permissions = var.certificate_permissions_full
  storage_permissions     = var.storage_permissions_full


  lifecycle {
    create_before_destroy = true
  }

}
//**********************************************************************************************


// Sets up additional access policies for Key Vault if required
//**********************************************************************************************
resource "azurerm_key_vault_access_policy" "policy" {
  for_each                = var.policies
  key_vault_id            = azurerm_key_vault.keyvault.id
  tenant_id               = each.value.tenant_id 
  object_id               = each.value.object_id
  key_permissions         = coalescelist(each.value.key_permissions, var.key_permissions_full)
  secret_permissions      = coalescelist(each.value.secret_permissions, var.secret_permissions_full)
  certificate_permissions = coalescelist(each.value.certificate_permissions, var.certificate_permissions_full)
  storage_permissions     = coalescelist(each.value.storage_permissions, var.storage_permissions_full)
}
//**********************************************************************************************