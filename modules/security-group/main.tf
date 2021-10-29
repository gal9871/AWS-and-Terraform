resource "aws_security_group" "security_group" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  # egress = var.egress
  # ingress = var.ingress
  tags = var.tags
}