 
# iam-role Module

Creates an IAM role with a flexible trust policy and attaches managed policies.

## Why Use This Module?

- Roles are essential for granting permissions to AWS services, external IdPs, or cross‑account access.
- The trust policy controls **who** can assume the role; the attached policies define **what** they can do.

## Important Logic

- Uses `data "aws_iam_policy_document"` to build the trust policy JSON safely.
- **Principals** can be AWS accounts, services (`ec2.amazonaws.com`), or federated users.
- Optional `condition` block adds security constraints (e.g., `StringEquals` with `sts:ExternalId`).

## Example

```hcl
module "ec2_role" {
  source = "./modules/iam-role"
  name = "web-server-role"
  principal_type = "Service"
  principal_identifiers = ["ec2.amazonaws.com"]
  policy_arns = {
    "s3" = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  }
}