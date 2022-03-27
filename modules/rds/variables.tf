variable "allocated_storage" {
  default = 20
}

variable "max_allocated_storage" {
  default = 1000
}

variable "engine" {
  default = "postgres"
}

variable "engine_version" {
  default = "13.4"
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "name" {
  default = "mydb"
}

variable "username" {
  default = "postgres"
}

variable "parameter_group_name" {
  default = "default.postgres13"
}

variable "subnet_frontend"{

}

variable "subnet_backend"{

}

variable "vpc_id"{
  
}