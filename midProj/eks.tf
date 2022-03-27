module "eks" {
  source          = "C:\\Users\\gal98\\OpsSchool-new\\kubernetes\\materials\\eks-terraform"
  vpc_id          = module.main_vpc.aws_vpc_id
  private_subnets = [module.private_subnet_1.aws_subnet_id, module.private_subnet_2.aws_subnet_id]
  jenkins_role    = module.jenkins.jenkins_role_arn
  consul_sg       = module.promcol.sg-id
}