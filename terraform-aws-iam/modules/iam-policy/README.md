 
# iam-policy Module

Creates a **custom** managed IAM policy from a list of statements.

## Why Use This Module?

- Enforces the principle of least privilege by writing only needed permissions.
- Policies are reusable across users, groups, and roles.

## Important Logic

- `dynamic "statement"` – iterates over `var.statements` to build a multi‑statement policy.
- Uses `aws_iam_policy_document` to automatically merge and validate JSON.
- No need to write raw JSON; keeps HCL clean.

## Example

```hcl
module "s3_list_policy" {
  source = "./modules/iam-policy"
  name = "ListMyBucket"
  statements = [
    {
      effect    = "Allow"
      actions   = ["s3:ListBucket"]
      resources = ["arn:aws:s3:::my-bucket"]
    }
  ]
}