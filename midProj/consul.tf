module "consul" {
    source = "C:\\Users\\gal98\\OpsSchool-new\\service_discovery\\solutions\\terraform"
    public_subnet_a = module.public_subnet_1.aws_subnet_id
    public_subnet_b = module.public_subnet_2.aws_subnet_id
    vpc_id = module.main_vpc.aws_vpc_id
}