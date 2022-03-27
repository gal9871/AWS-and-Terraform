module "elk" {
  source          = "..\\modules\\elk"
  vpc_id          = module.main_vpc.aws_vpc_id
  aws_subnet_ids  = [module.private_subnet_1.aws_subnet_id]
  consul_sg       = module.promcol.consul_sg
  consul_role     = module.promcol.consul_role
}