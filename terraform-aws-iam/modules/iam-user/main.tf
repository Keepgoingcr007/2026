# versions.tf - Module level
terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

# Create IAM user
resource "aws_iam_user" "this" {
  name = var.name
  path = var.path
  tags = var.tags
}

# Add user to groups
resource "aws_iam_user_group_membership" "this" {
  count = length(var.groups) > 0 ? 1 : 0
  
  user   = aws_iam_user.this.name
  groups = var.groups
}

# Attach direct policies to user
resource "aws_iam_user_policy_attachment" "this" {
  for_each = toset(var.policy_arns)
  
  user       = aws_iam_user.this.name
  policy_arn = each.value
}

# Create console login profile
resource "aws_iam_user_login_profile" "this" {
  count = var.create_console_access ? 1 : 0
  
  user                    = aws_iam_user.this.name
  password_reset_required = var.password_reset_required
  pgp_key                 = var.pgp_key
}

# Create API access keys
resource "aws_iam_access_key" "this" {
  count = var.create_api_keys ? 1 : 0
  
  user    = aws_iam_user.this.name
  pgp_key = var.pgp_key
}

# Generate random password if not using PGP and console access is enabled
resource "random_password" "this" {
  count = var.create_console_access && var.pgp_key == null ? 1 : 0
  
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Local values for password handling
locals {
  # If console access is enabled and no PGP key is provided, use the random password
  console_password = var.create_console_access ? (
    var.pgp_key != null ? aws_iam_user_login_profile.this[0].encrypted_password : (
      random_password.this[0].result
    )
  ) : null
  
  # For access keys with PGP encryption
  encrypted_secret = var.create_api_keys && var.pgp_key != null ? aws_iam_access_key.this[0].encrypted_secret : null
  
  # Plaintext secret (only when no PGP)
  plaintext_secret = var.create_api_keys && var.pgp_key == null ? aws_iam_access_key.this[0].secret : null
}