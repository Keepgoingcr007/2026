 
# iam-account Module

Configures AWS **account-level** IAM settings.

## Why Use This Module?

- Sets a custom account alias for your AWS account (easier to recognise in console/CLI).
- Enforces a strong password policy for all IAM users in the account.

## Important Logic

- `aws_iam_account_alias`: uses `count = var.account_alias != "" ? 1 : 0` → only creates alias if a non‑empty string is provided.
- `aws_iam_account_password_policy`: wrapped in a `count` guard to make the policy optional.
- **Password reuse prevention** blocks users from cycling through recent passwords.

## Example

```hcl
module "account_settings" {
  source = "./modules/iam-account"
  account_alias = "my-company-prod"
  configure_password_policy = true
  minimum_password_length = 14
  password_reuse_prevention = 5
}