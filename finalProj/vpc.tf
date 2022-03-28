module "main_vpc" {
  source = "..\\modules\\vpc"
  tags = { Name = "prod-vpc",
    Environment = "prod",
  Purpuse = "vpc for web app" }
  cidr_block = var.network_info
}