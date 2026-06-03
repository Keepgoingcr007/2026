 
# iam-group Module

Creates an IAM group and attaches managed policies.

## Why Use This Module?

- Groups simplify permission management for multiple users (admins, developers, auditors).
- Attaching policies via `for_each` allows dynamic binding without hardcoding.

## Important Logic

- `for_each = var.policy_arns` – allows passing a map or set of policy ARNs.
- Each policy is attached independently; Terraform handles adds/removes cleanly.

## Example

```hcl
module "developers" {
  source = "./modules/iam-group"
  name = "developers"
  policy_arns = {
    "s3-readonly" = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    "ec2-readonly" = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  }
}