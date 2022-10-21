// Required Variables
//**********************************************************************************************
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the resources"
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists"
}

variable "tenant_id" {
  description = "(Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault"
  type        = string
}

variable "object_id" {
  description = "(Required) The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault"
}
//**********************************************************************************************


// Optional Variables
//**********************************************************************************************
variable "keyvault_name" {
  type = string
  description = "(Required) Name of Key vault"
}
variable "keyvault_prefix" {
  type        = string
  description = "(Required) Prefix for Postgresql server name"
  default     = "kv"
}

variable "keyvault_suffix" {
  type        = string
  description = "(Optional) Suffix for AKS cluster name"
  default     = ""
}

variable "create_random_string" {
  type        = bool
  description = "(Optional) Add random string to the keyvault name?"
  default     = false
}

variable "sku_name" {
  description = "(Optional) The Name of the SKU used for this Key Vault"
  type        = string
  default     = "standard"
}

variable "enabled_for_deployment" {
  type        = bool
  description = "(Optional) Boolean to enable vms to be able to fetch from keyvault."
  default     = true
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "(Optional) Boolean to enable vms to use keyvault certificates for disk encryption."
  default     = true
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "(Optional) Boolean to enable azure resource manager deployments to be able to fetch from keyvault."
  default     = false
}

variable "purge_protection_enabled" {
  type        = bool
  description = "(Optional) When purge protection is on, a vault or an object in the deleted state cannot be purged until the retention period has passed."
  default     = true
}

variable "network_acls" {
  description = "Object with attributes: `bypass`, `default_action`, `ip_rules`, `virtual_network_subnet_ids`. See https://www.terraform.io/docs/providers/azurerm/r/key_vault.html#bypass for more informations."
  default     = null

  type = object({
    bypass                     = string,
    default_action             = string,
    ip_rules                   = list(string),
    virtual_network_subnet_ids = list(string),
  })
}

variable "nacl_default_action" {
  description = "(Optional) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids"
  type        = string
  default     = "Deny"
}

variable "nacl_allowed_ips" {
  type        = list(string)
  description = "(Optional)  One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault"
  default     = []
}

variable "nacl_allowed_subnets" {
  type        = list(string)
  description = "(Optional) One or more Subnet ID's which should be able to access this Key Vault"
  default     = []
}

variable "az_svcs_bypass" {
  type        = string
  description = "(Optional) Specifies which traffic can bypass the network rules"
  default     = "AzureServices"
}

variable "keyvault_restore_name" {
  type        = string
  description = "(Optional) Name of the soft deleted Keyvautl which should be restored"
  default     = null
}

variable "resource_tags" {
  type        = map(string)
  description = "(Optional) Tags for resources"
  default     = {}
}

variable "deployment_tags" {
  type        = map(string)
  description = "(Optional) Tags for deployment"
  default     = {}
}

variable "it_depends_on" {
  type        = any
  description = "(Optional) To define explicit dependencies if required"
  default     = null
}
//**********************************************************************************************


// Optional variables: Key Vault access policies 
//**********************************************************************************************
variable "policies" {
  type = map(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    storage_permissions     = list(string)
  }))
  description = "(optional) Define an additional Azure Key Vault access policies"
  default     = {}
}
variable "key_permissions_full" {
  type        = list(string)
  description = "(Optional) List of full key permissions for default accesss policy"
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge",
  "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}
variable "secret_permissions_full" {
  type        = list(string)
  description = "(Optional) List of full secret permissions for default accesss policy"
  default     = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}
variable "certificate_permissions_full" {
  type        = list(string)
  description = "(Optional) List of full certificate permissions for default accesss policy"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers",
  "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update", "backup", "restore"]
}
variable "storage_permissions_full" {
  type        = list(string)
  description = "(Optional) List of full storage permissions for default accesss policy"
  default = ["backup", "delete", "deletesas", "get", "getsas", "list", "listsas",
  "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"]
}

variable "secrets" {
  type = map(object({
    name  = string
    value = string
  }))
  description = "(Optional) Secrets to be added"
  default     = {}
}
//**********************************************************************************************