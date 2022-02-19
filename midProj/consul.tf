module "consul" {
  #source    = "C:\\Users\\gal98\\OpsSchool-new\\service_discovery\\solutions\\terraform"
  source = "github.com/gal9871/service_discovery.git//solutions/terraform?ref=6e714b9aaa3a553a64816e1e21fe4dc7ad35e1b3"

  subnet_id = [module.private_subnet_1.aws_subnet_id, module.private_subnet_2.aws_subnet_id]
  vpc_id    = module.main_vpc.aws_vpc_id
}