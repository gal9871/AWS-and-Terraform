module "rds" {
  source     = "..\\modules\\rds"
  subnet_frontend = module.public_subnet_1.aws_subnet_id
  subnet_backend = module.public_subnet_2.aws_subnet_id
}