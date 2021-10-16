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


module "sg-rule-in-1" {
  source      = "..\\modules\\security-group-rule"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.nginx-sg.aws_security_group_id
}

module "sg-rule-in-2" {
  source      = "..\\modules\\security-group-rule"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.nginx-sg.aws_security_group_id
}

module "sg-rule-out" {
  source      = "..\\modules\\security-group-rule"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.nginx-sg.aws_security_group_id
}
# module "nginx-instance-1"{
#     source = "..\\modules\\ec2-instance"
# }
