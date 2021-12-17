module "main_vpc" {
  source = "..\\modules\\vpc"
  tags = { Name = "prod-vpc",
    Environment = "prod",
  Purpuse = "vpc for web app" }
  cidr_block = var.network_info
}

module "public_subnet_1" {
  source                  = "..\\modules\\subnet"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  vpc_id                  = module.main_vpc.aws_vpc_id
  cidr_block              = cidrsubnet(var.network_info, 8, 0) #10.0.0.0/24
  tags = { Name = "public-subnet-1",
    Environment = "prod",
  Purpuse = "public subnet for web app" }
}

module "public_subnet_2" {
  source                  = "..\\modules\\subnet"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  vpc_id                  = module.main_vpc.aws_vpc_id
  cidr_block              = cidrsubnet(var.network_info, 8, 1) #10.0.1.0/24
  tags = { Name = "public-subnet-2",
    Environment = "prod",
  Purpuse = "public subnet for web app" }
}

module "private_subnet_1" {
  source                  = "..\\modules\\subnet"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
  vpc_id                  = module.main_vpc.aws_vpc_id
  cidr_block              = cidrsubnet(var.network_info, 8, 10) #10.0.10.0/24
  tags = { Name = "private-subnet-2",
    Environment = "prod",
  Purpuse = "private subnet for web app" }
}

module "private_subnet_2" {
  source                  = "..\\modules\\subnet"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"
  vpc_id                  = module.main_vpc.aws_vpc_id
  cidr_block              = cidrsubnet(var.network_info, 8, 11) #10.0.11.0/24
  tags = { Name = "private-subnet-2",
    Environment = "prod",
  Purpuse = "private subnet for web app" }
}

module "igw" {
  source = "..\\modules\\internet-gateway"
  vpc_id = module.main_vpc.aws_vpc_id
  tags = { Name = "igw",
  Environment = "prod" }
}

module "eip" {
  source = "..\\modules\\eip"

}

module "nat_gateway" {
  source        = "..\\modules\\nat-gateway"
  allocation_id = module.eip.eip_alloc_id
  subnet_id     = module.public_subnet_1.aws_subnet_id

  tags = {
    Name        = "gw NAT",
    Environment = "prod"
  }
  depends_on = [module.igw.igw-id, module.eip.eip_alloc_id]
}

module "nat-route-table" {
  source     = "..\\modules\\route-table"
  vpc_id     = module.main_vpc.aws_vpc_id
  cidr_block = "0.0.0.0/0"
  gateway_id = module.nat_gateway.ngw_id
}

module "igw-route-table" {
  source     = "..\\modules\\route-table"
  vpc_id     = module.main_vpc.aws_vpc_id
  cidr_block = "0.0.0.0/0"
  gateway_id = module.igw.igw-id
}

module "rt-assoc-pub-1" {
  source         = "..\\modules\\route-table-association"
  subnet_id      = module.public_subnet_1.aws_subnet_id
  route_table_id = module.igw-route-table.route_table_id
}

module "rt-assoc-pub-2" {
  source         = "..\\modules\\route-table-association"
  subnet_id      = module.public_subnet_2.aws_subnet_id
  route_table_id = module.igw-route-table.route_table_id
}

module "rt-assoc-prv-1" {
  source         = "..\\modules\\route-table-association"
  subnet_id      = module.private_subnet_1.aws_subnet_id
  route_table_id = module.nat-route-table.route_table_id
}

module "rt-assoc-prv-2" {
  source         = "..\\modules\\route-table-association"
  subnet_id      = module.private_subnet_2.aws_subnet_id
  route_table_id = module.nat-route-table.route_table_id
}



module "nginx-sg" {
  source      = "..\\modules\\security-group"
  name        = "nginx-server-sg"
  description = "allow ssh,http"
  vpc_id      = module.main_vpc.aws_vpc_id
  tags = {
    Name    = "allow_http-ssh",
    Owner   = "Gal",
    Purpuse = "SG for NGINX"
  }
}

data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
module "sg-rule-in-1" {
  source            = "..\\modules\\security-group-rule"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.nginx-sg.aws_security_group_id
}

module "sg-rule-in-2" {
  source            = "..\\modules\\security-group-rule"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.nginx-sg.aws_security_group_id
}

module "sg-rule-out" {
  source            = "..\\modules\\security-group-rule"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.nginx-sg.aws_security_group_id
}


module "nginx-instance-1" {
  source                 = "..\\modules\\ec2-instance"
  count                  = 1
  subnet_id              = module.public_subnet_1.aws_subnet_id
  ami                    = data.aws_ami.aws-linux.id
  availability_zone      = "us-east-1a"
  instance_type          = "t2.micro"
  iam_instance_profile   = module.nginx_instance_profile.profile-arn
  vpc_security_group_ids = [module.nginx-sg.aws_security_group_id]
  tags = {
    Owner     = "Gal Segal"
    Terraform = "true"
    Purpose   = "nginx server"
    Name      = "nginx-1"
  }
  key_name  = "galsekey"
	user_data = "${file("userdata.sh")}"
}

module "nginx-instance-2" {
  source                 = "..\\modules\\ec2-instance"
  count                  = 1
  subnet_id              = module.public_subnet_2.aws_subnet_id
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1b"
  iam_instance_profile   = module.nginx_instance_profile.profile-arn
  vpc_security_group_ids = [module.nginx-sg.aws_security_group_id]
  tags = {
    Owner     = "Gal Segal"
    Terraform = "true"
    Purpose   = "nginx server"
    Name      = "nginx-2"
  }
key_name  = "galsekey"
user_data = "${file("userdata.sh")}"

}

module "lb" {
  source             = "..\\modules\\lb"
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.nginx-sg.aws_security_group_id]
  subnets            = [module.public_subnet_1.aws_subnet_id, module.public_subnet_2.aws_subnet_id]

  tags = {
    Name        = "nginx-lb"
    Environment = "production"
    type        = "Application"
  }
}

module "nginx-tg" {
  source   = "..\\modules\\target-groups"
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.main_vpc.aws_vpc_id
}

module "listener-lb" {
  source            = "..\\modules\\lb-listeners"
  load_balancer_arn = module.lb.lb-arn
  port              = "80"
  protocol          = "HTTP"
  target_group_arn  = module.nginx-tg.tg-arn
}

module "lb-tg-attachment-nginx-1" {
  source           = "..\\modules\\lb-tg-attachment"
  target_group_arn = module.nginx-tg.tg-arn
  target_id        = join("\",\"", module.nginx-instance-1[0].ec2_instance_id)
  port             = 80
}

module "lb-tg-attachment-nginx-2" {
  source           = "..\\modules\\lb-tg-attachment"
  target_group_arn = module.nginx-tg.tg-arn
  target_id        = join("\",\"", module.nginx-instance-2[0].ec2_instance_id)
  port             = 80
}


module "db-server-1" {
  source                 = "..\\modules\\ec2-instance"
  count                  = 1
  subnet_id              = module.private_subnet_1.aws_subnet_id
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [module.nginx-sg.aws_security_group_id]
  tags = {
    Owner     = "Gal Segal"
    Terraform = "true"
    Purpose   = "db server"
    Name      = "DB"
  }
  key_name  = "galsekey"
  user_data = ""

}

module "db-server-2" {
  source                 = "..\\modules\\ec2-instance"
  count                  = 1
  subnet_id              = module.private_subnet_2.aws_subnet_id
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1b"
  vpc_security_group_ids = [module.nginx-sg.aws_security_group_id]
  tags = {
    Owner     = "Gal Segal"
    Terraform = "true"
    Purpose   = "DB server"
    Name      = "DB"
  }
  key_name  = "galsekey"
  user_data = ""

}

module "nginx_role" {
  source = "..\\modules\\iam-role"
  name   = "nginx-role-s3"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = [module.S3-put-access.policy-arn]
  tags                = {
    Purpose = "role for nginx instance to access S3"
  }
}

module "S3-put-access" {
  source = "..\\modules\\iam-policy"
  name        = "s3-policy"
  description = "S3 put access policy"
  policy      = jsonencode({
  "Version":"2012-10-17"
  "Statement":[
    {
      "Sid":"S3"
      "Effect":"Allow"
      "Action":["s3:*"]
      "Resource":"*"
    },
  ]
})
}

module "nginx_instance_profile" {
  source = "..\\modules\\iam-instance-profile"
  name = "nginx-profile"
  role = module.nginx_role.role-name
}

module "ansible_sg"{
  source = "..\\..\\configuration-management\\materials\\terraform"
 # source = "github.com/gal9871/configuration-management.git//materials/terraform?ref=d30233c954e518048c3c2c0ccc36a50127f6b82f"
  vpc_id        = module.main_vpc.aws_vpc_id
  subnet_id     = module.public_subnet_1.aws_subnet_id
}