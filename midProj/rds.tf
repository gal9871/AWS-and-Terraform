module "rds" {
  source     = "..\\modules\\rds"
  subnet_frontend = module.public_subnet_1.aws_subnet_id
  vpc_id    = module.main_vpc.aws_vpc_id
  subnet_backend = module.public_subnet_2.aws_subnet_id
}
output "endpoint" {
  value = module.rds.rds_endpoint
}