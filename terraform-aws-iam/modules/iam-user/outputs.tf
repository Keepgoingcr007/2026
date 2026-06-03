 
output "user_arn" {
  description = "ARN of the IAM user"
  value       = aws_iam_user.this.arn
}

output "user_name" {
  description = "Name of the IAM user"
  value       = aws_iam_user.this.name
}

output "user_unique_id" {
  description = "Unique ID of the IAM user"
  value       = aws_iam_user.this.unique_id
}

output "login_profile_encrypted_password" {
  description = "Encrypted password for console login (only if PGP key provided)"
  value       = var.create_console_access && var.pgp_key != null ? aws_iam_user_login_profile.this[0].encrypted_password : null
  sensitive   = true
}

output "login_profile_password" {
  description = "Plaintext password for console login (only when no PGP key)"
  value       = var.create_console_access && var.pgp_key == null ? local.console_password : null
  sensitive   = true
}

output "access_key_id" {
  description = "Access key ID"
  value       = var.create_api_keys ? aws_iam_access_key.this[0].id : null
}

output "secret_access_key" {
  description = "Secret access key (plaintext if no PGP, encrypted if PGP provided)"
  value       = var.create_api_keys ? (var.pgp_key != null ? local.encrypted_secret : local.plaintext_secret) : null
  sensitive   = true
}

output "key_fingerprint" {
  description = "Fingerprint of the PGP key used for encryption"
  value       = var.create_api_keys && var.pgp_key != null ? aws_iam_access_key.this[0].key_fingerprint : null
}