resource "aws_lb_target_group" "tg" {
  name     = var.name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  health_check {
    matcher = "200"
    path    = "/index.html"
  }
  target_type = var.target_type
  stickiness {
    cookie_duration = 60
    type            = "lb_cookie"
  }
}