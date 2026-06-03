 
# iam-read-only-policy Module

Predefined **read‑only** policy covering common AWS services.

## Why Use This Module?

- Quick way to grant audit/monitoring access without reinventing the wheel.
- Encourages read‑only by default for non‑production roles.

## Important Logic

- Policy uses `Describe*`, `Get*`, `List*` actions – never `Create`, `Delete`, `Update`.
- `var.resources` defaults to `["*"]` but can be restricted to specific ARNs for extra security.

## Example

```hcl
module "readonly_audit" {
  source = "./modules/iam-read-only-policy"
  name   = "audit-readonly"
  resources = ["*"]
}