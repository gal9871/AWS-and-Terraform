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
