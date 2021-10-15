variable "egress" {
  type = map
}

variable "ingress" {
  type = map
  default = {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "description" {
  type = string
}

variable "name" {
    type = string
}

variable "vpc_id" {
    type = string
}