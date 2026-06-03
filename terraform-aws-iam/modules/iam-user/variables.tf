 
variable "name" {
  description = "IAM username"
  type        = string
}

variable "path" {
  description = "Path for the IAM user"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags to apply to the IAM user"
  type        = map(string)
  default     = {}
}

variable "create_console_access" {
  description = "Whether to create console login profile"
  type        = bool
  default     = false
}

variable "password_reset_required" {
  description = "Whether user must reset password on first login"
  type        = bool
  default     = true
}

variable "create_api_keys" {
  description = "Whether to create API access keys"
  type        = bool
  default     = false
}

variable "pgp_key" {
  description = "PGP key to encrypt the access key secret (optional)"
  type        = string
  default     = null
}

variable "groups" {
  description = "List of IAM groups to add the user to"
  type        = list(string)
  default     = []
}

variable "policy_arns" {
  description = "List of policy ARNs to attach directly to the user"
  type        = list(string)
  default     = []
}