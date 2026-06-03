 


## Module 7: `iam-oidc-provider`

### `main.tf`


resource "aws_iam_openid_connect_provider" "this" {
  url            = var.url
  client_id_list = var.client_ids
  thumbprint_list = var.thumbprints
  tags           = var.tags
}