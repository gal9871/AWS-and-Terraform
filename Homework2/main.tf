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

module "igw" {
  source = "..\\modules\\internet-gateway"
  vpc_id     = module.main_vpc.aws_vpc_id
  tags = { Name    = "igw",
    Environment   = "prod"}
}

module "nat_gateway-1" {
  source = "..\\modules\\nat-gateway"
  allocation_id = var.allocation_id
  subnet_id     = module.public_subnet_1.aws_subnet_id

  tags = {
    Name = "gw NAT",
    Environment = "prod"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [module.igw.igw-id]
}

module "nat_gateway-2" {
  source = "..\\modules\\nat-gateway"
  allocation_id = var.allocation_id
  subnet_id     = module.public_subnet_2.aws_subnet_id

  tags = {
    Name = "gw NAT",
    Environment = "prod"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [ module.igw.igw-id]
}