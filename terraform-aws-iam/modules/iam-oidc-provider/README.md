 
# iam-oidc-provider Module

Registers an OpenID Connect (OIDC) identity provider with AWS IAM.

## Why Use This Module?

- Allows external OIDC‑compatible IdPs (GitHub Actions, GitLab, EKS, Google, Azure AD) to assume IAM roles.
- Mandatory for **IRSA** (IAM Roles for Service Accounts) on EKS.

## Important Logic

- `url` – must be exactly the issuer URL used by the IdP (e.g., `https://token.actions.githubusercontent.com`).
- `thumbprint_list` – required for certificate validation; AWS recommends using the root CA thumbprint.
- **Client IDs** – the audience (`aud`) claim that the IdP will send; often `sts.amazonaws.com` or a custom value.

## Example

```hcl
module "github_oidc" {
  source = "./modules/iam-oidc-provider"
  url = "https://token.actions.githubusercontent.com"
  client_ids = ["sts.amazonaws.com"]
  thumbprints = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}