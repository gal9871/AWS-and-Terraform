module "ansible_sg" {
  source = "..\\..\\configuration-management\\materials\\terraform"
  # source = "github.com/gal9871/configuration-management.git//materials/terraform?ref=d30233c954e518048c3c2c0ccc36a50127f6b82f"
  vpc_id    = module.main_vpc.aws_vpc_id
  subnet_id = module.public_subnet_1.aws_subnet_id
}