variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}


variable "target_type" {
  type    = string
  default = "instance"
}