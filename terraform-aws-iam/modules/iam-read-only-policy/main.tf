 



## Module 6: `iam-read-only-policy`

### `main.tf`


resource "aws_iam_policy" "this" {
  name        = var.name
  description = var.description
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ec2:Describe*",
          "s3:Get*",
          "s3:List*",
          "rds:Describe*",
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "iam:Get*",
          "iam:List*"
        ]
        Resource = var.resources  # usually "*" or specific ARNs
      }
    ]
  })
}