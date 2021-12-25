resource "aws_iam_role" "iam_role" {
  name               = var.name
  assume_role_policy = var.assume_role_policy # (not shown)
  # managed_policy_arns = var.managed_policy_arns
  tags = var.tags
}