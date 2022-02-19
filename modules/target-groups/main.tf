resource "aws_lb_target_group" "tg" {
  name     = var.name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  health_check {
    port    = var.health_check_port
    matcher = var.health_check_matcher
    path    = var.health_check_path
  }
  target_type = var.target_type
}