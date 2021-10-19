module "main_vpc" {
  source = "..\\modules\\vpc"
  tags =  { Name    = "prod-vpc",
    Environment   = "prod",
    Purpuse = "vpc for web app"}
    cidr_block = var.network_info
}

module "public_subnet_1" {
  source = "..\\modules\\subnet"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  vpc_id     = module.main_vpc.aws_vpc_id
  cidr_block = cidrsubnet(var.network_info, 8, 0)
  tags = { Name    = "public-subnet-1",
    Environment   = "prod",
    Purpuse = "public subnet for web app"}
}

module "public_subnet_2" {
  source = "..\\modules\\subnet"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  vpc_id     = module.main_vpc.aws_vpc_id
  cidr_block = cidrsubnet(var.network_info, 8, 1)
  tags = { Name    = "public-subnet-2",
    Environment   = "prod",
    Purpuse = "public subnet for web app"}
}

module "private_subnet_1" {
  source = "..\\modules\\subnet"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"
  vpc_id     = module.main_vpc.aws_vpc_id
  cidr_block = cidrsubnet(var.network_info, 8, 10)
  tags = { Name    = "private-subnet-2",
    Environment   = "prod",
    Purpuse = "private subnet for web app"}
}

module "private_subnet_2" {
  source = "..\\modules\\subnet"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1b"
  vpc_id     = module.main_vpc.aws_vpc_id
  cidr_block = cidrsubnet(var.network_info, 8, 11)
  tags = { Name    = "private-subnet-2",
    Environment   = "prod",
    Purpuse = "private subnet for web app"}
}