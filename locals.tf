// Local Values
//**********************************************************************************************
locals {
  timeout_duration = "1h"
  keyvault_name    = var.create_random_string ? "${var.keyvault_name}-${random_string.kv_name.result}" : var.keyvault_name
}
//**********************************************************************************************