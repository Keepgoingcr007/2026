# Terraform AWS IAM Modules

A reusable, production-ready collection of Terraform modules for managing AWS IAM resources.

## Modules Included

- `iam-account` – Account-level password policy and alias.
- `iam-user` – Create IAM users with login profile and access keys.
- `iam-group` – Manage groups and attach policies.
- `iam-role` – Create roles with trust policies.
- `iam-policy` – Custom managed policies.
- `iam-read-only-policy` – Predefined read‑only policy.
- `iam-oidc-provider` – Configure OIDC identity providers (e.g., GitHub Actions, EKS).
- `iam-role-for-service-accounts` – IRSA roles for Kubernetes service accounts.

Each module includes its own detailed `README.md` explaining logic and important lines.

## Usage

```hcl
module "my_user" {
  source = "./modules/iam-user"
  name   = "john"
  create_console_access = true
  create_api_keys      = true
}