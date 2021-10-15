variable "ami_id"{
    type = string
}

variable "instance_type"{
    type = string
    default = "t3.micro"
}

variable "subnet_id"{
    type = string
}

variable "vpc_security_group_ids" {
    type = string
}

variable "user_data" {
  type = string
  default = ""
}

variable "tags" {
    type = map
}