resource "azurerm_key_vault_secret" "secret" {
  for_each     = var.secrets
  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.keyvault.id
}