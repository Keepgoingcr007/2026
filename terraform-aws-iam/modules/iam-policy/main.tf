 



## Module 5: `iam-policy`

### `main.tf`


data "aws_iam_policy_document" "policy" {
  dynamic "statement" {
    for_each = var.statements
    content {
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_policy" "this" {
  name        = var.name
  path        = var.path
  description = var.description
  policy      = data.aws_iam_policy_document.policy.json
  tags        = var.tags
}