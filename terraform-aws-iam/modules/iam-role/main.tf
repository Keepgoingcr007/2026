 


## Module 4: `iam-role`

### `main.tf`


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = var.principal_type
      identifiers = var.principal_identifiers
    }
    condition {
      test     = var.condition_test
      variable = var.condition_variable
      values   = var.condition_values
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  description        = var.description
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = var.policy_arns
  role       = aws_iam_role.this.name
  policy_arn = each.value
}