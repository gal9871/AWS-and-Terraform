module "main_vpc" {
  source = "..\\modules\\vpc"
  tags =  { Name    = "prod-vpc",
    Environment   = "prod",
    Purpuse = "vpc for web app"}
    cidr_block = "10.0.0.0/16"
}