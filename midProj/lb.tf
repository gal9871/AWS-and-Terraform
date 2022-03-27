module "lb" {
  source             = "..\\modules\\lb"
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.nginx-sg.aws_security_group_id]
  subnets            = [module.public_subnet_1.aws_subnet_id, module.public_subnet_2.aws_subnet_id]

  tags = {
    Environment = "production"
    type        = "Application"
  }
}



module "prometheus-tg" {
  source               = "..\\modules\\target-groups"
  name                 = "promcol"
  port                 = 9090
  protocol             = "HTTP"
  vpc_id               = module.main_vpc.aws_vpc_id
  health_check_path    = "/"
  health_check_port    = 9090
  health_check_matcher = 302

}

module "prometehus-listener-lb" {
  source            = "..\\modules\\lb-listeners"
  load_balancer_arn = module.lb.lb-arn
  port              = "9090"
  protocol          = "HTTP"
  target_group_arn  = module.prometheus-tg.tg-arn
}


module "lb-tg-attachment-prometheus" {
  source           = "..\\modules\\lb-tg-attachment"
  target_group_arn = module.prometheus-tg.tg-arn
  target_id        = module.promcol.prometheus_server_id
  port             = 9090
  depends_on       = [module.promcol]
}


module "grafana-tg" {
  source               = "..\\modules\\target-groups"
  name                 = "Grafana"
  port                 = 3000
  protocol             = "HTTP"
  vpc_id               = module.main_vpc.aws_vpc_id
  health_check_path    = "/"
  health_check_port    = 3000
  health_check_matcher = 302

}

module "grafana-listener-lb" {
  source            = "..\\modules\\lb-listeners"
  load_balancer_arn = module.lb.lb-arn
  port              = "3000"
  protocol          = "HTTP"
  target_group_arn  = module.grafana-tg.tg-arn
}


module "lb-tg-attachment-grafana" {
  source           = "..\\modules\\lb-tg-attachment"
  target_group_arn = module.grafana-tg.tg-arn
  target_id        = module.promcol.prometheus_server_id
  port             = 3000
  depends_on       = [module.promcol]
}

module "elk-tg" {
  source               = "..\\modules\\target-groups"
  name                 = "ELK"
  port                 = 5601
  protocol             = "HTTP"
  vpc_id               = module.main_vpc.aws_vpc_id
  health_check_path    = "/"
  health_check_port    = 5601
  health_check_matcher = 302

}

module "elk-listener-lb" {
  source            = "..\\modules\\lb-listeners"
  load_balancer_arn = module.lb.lb-arn
  port              = "5601"
  protocol          = "HTTP"
  target_group_arn  = module.elk-tg.tg-arn
}


module "lb-tg-attachment-elk" {
  source           = "..\\modules\\lb-tg-attachment"
  target_group_arn = module.elk-tg.tg-arn
  target_id        = module.elk.elk_server_id
  port             = 5601
  depends_on       = [module.elk]
}