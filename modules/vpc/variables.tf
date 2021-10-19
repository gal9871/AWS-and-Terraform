variable "cidr_block" {
  type = string
}

variable "tags" {
  type = map
}

variable "instance_tenancy" {
  type = string
  default = "default"
}