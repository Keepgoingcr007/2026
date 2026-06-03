 
# iam-role-for-service-accounts Module

Creates an IAM role that can be assumed by a **Kubernetes service account** via OIDC (IRSA).

## Why Use This Module?

- Enables pods running on EKS to obtain AWS credentials without hardcoding secrets.
- Follows the principle of least privilege per service account.

## Important Logic

- Uses `sts:AssumeRoleWithWebIdentity` – the correct action for OIDC federated roles.
- **Condition** `"${var.oidc_provider_url}:sub"` matches the exact service account in the format `system:serviceaccount:<namespace>:<sa_name>`.
- The OIDC provider URL is stripped of `https://` because AWS expects the hostname in the condition key.

## Example

```hcl
module "s3_irsa" {
  source = "./modules/iam-role-for-service-accounts"
  name = "my-app-s3-reader"
  oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.region.amazonaws.com/id/..."
  oidc_provider_url = "oidc.eks.region.amazonaws.com/id/..."
  namespace = "my-namespace"
  service_account_name = "my-sa"
  policy_arns = {
    "s3-read" = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }
}