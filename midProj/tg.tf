module "nginx-tg" {
  source   = "..\\modules\\target-groups"
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.main_vpc.aws_vpc_id
}

module "listener-lb" {
  source            = "..\\modules\\lb-listeners"
  load_balancer_arn = module.lb.lb-arn
  port              = "80"
  protocol          = "HTTP"
  target_group_arn  = module.nginx-tg.tg-arn
}

module "lb-tg-attachment-nginx-1" {
  source           = "..\\modules\\lb-tg-attachment"
  target_group_arn = module.nginx-tg.tg-arn
  target_id        = join("\",\"", module.nginx-instance-1[0].ec2_instance_id)
  port             = 80
}

module "lb-tg-attachment-nginx-2" {
  source           = "..\\modules\\lb-tg-attachment"
  target_group_arn = module.nginx-tg.tg-arn
  target_id        = join("\",\"", module.nginx-instance-2[0].ec2_instance_id)
  port             = 80
}