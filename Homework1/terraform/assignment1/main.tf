resource "aws_default_vpc" "default" {

}

module "nginx-sg" {
  source      = "..\\modules\\security-group"
  name        = "nginx-server-sg"
  description = "allow ssh,http"
  vpc_id      = aws_default_vpc.default.id
  ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }]
  egress = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]

    tags = {
    Name = "allow_http-ssh",
    Owner = "Gal",
    Purpuse = "SG for NGINX"
  }
}

# module "nginx-instance-1"{
#     source = "..\\modules\\ec2-instance"
# }
