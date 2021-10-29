resource "aws_iam_policy" "iam-policy" {
  name        = var.name
  description = var.description
  policy      = var.policy
}