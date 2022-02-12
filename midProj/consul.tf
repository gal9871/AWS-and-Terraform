module "consul" {
  source    = "C:\\Users\\gal98\\OpsSchool-new\\service_discovery\\solutions\\terraform"
  subnet_id = [module.private_subnet_1.aws_subnet_id, module.private_subnet_2.aws_subnet_id]
  vpc_id    = module.main_vpc.aws_vpc_id
}