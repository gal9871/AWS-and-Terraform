resource "aws_default_vpc" "default" {

}

module "nginx-sg" {
  source      = "..\\modules\\security-group"
  name        = "nginx-server-sg"
  description = "allow ssh,http"
  vpc_id      = aws_default_vpc.default.id
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
  count                  = 2
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.nginx-sg.aws_security_group_id]
  tags = {
    Owner     = "Gal Segal"
    Terraform = "true"
    Purpose   = "nginx server"
    Name      = "nginx-${count.index}"
  }
  key_name  = "galsekey"
  user_data = <<EOT
#cloud-config
# update apt on boot
package_update: true
# install nginx
packages:
- nginx
write_files:
- content: |
    <!DOCTYPE html>
    <html>
    <head>
      <title>Assignment 1</title>
      <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
      <style>
        html, body {
          background: #000;
          height: 100%;
          width: 100%;
          padding: 0;
          margin: 0;
          display: flex;
          justify-content: center;
          align-items: center;
          flex-flow: column;
        }
        img { width: 250px; }
        svg { padding: 0 40px; }
        p {
          color: #fff;
          font-family: 'Courier New', Courier, monospace;
          text-align: center;
          padding: 10px 30px;
        }
      </style>
    </head>
    <body>
      <p>Welcome to Grandpa's Whiskey </p>
    </body>
    </html>
  path: /usr/share/app/index.html
  permissions: '0644'
runcmd:
- cp /usr/share/app/index.html /var/www/html/index.html
EOT

}

module "ebs" {
  source      = "..\\modules\\ebs"
  size        = 10
  count       = 2
  encrypted   = true
  instance_id = join("\",\"", module.nginx-instance-1[count.index].ec2_instance_id)
}
