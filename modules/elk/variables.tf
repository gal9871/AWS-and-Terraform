variable "aws_account_id" {
  type = string
  default = "727940474452"
}
variable "aws_region" {
  type = string
  default = "us-east-1"
}
variable "aws_profile" {
  type    = string
  default = "terraform"
}
variable "ssh_key_name" {
  type = string
  default = "galsekey"
}
variable "prefix_name" {
  type = string
  default = "gal"
}
variable "instance_count" {
  type    = number
  default = 1
}

variable "vpc_id" {
  type = string
}
# get subnet ids
variable "aws_subnet_ids"{
  type = list(string)
}

variable "consul_sg" {
  
}

variable "consul_role" {
  
}