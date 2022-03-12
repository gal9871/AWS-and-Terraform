module "jenkins" {
  source                   = "..\\..\\ci-cd\\assignments\\session-3"
  master_subnet            = module.public_subnet_1.aws_subnet_id
  agents_subnet            = [module.private_subnet_1.aws_subnet_id, module.private_subnet_2.aws_subnet_id]
  vpc_id                   = module.main_vpc.aws_vpc_id
  default_sg               = module.main_vpc.default_sg_id
  consul_security_group_id = module.promcol.sg-id
  agents_count             = 2
}