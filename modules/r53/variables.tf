variable "vpc_id" {
    type = string
}


variable "elk_ip" {
  
}

variable "jenkins_agents_ip" {
 type = list(string) 
}

variable "promcol_prv_ip" {
  
}

variable "consul_client_ip" {
  
}

variable "consul_servers_ip" {
  
}

variable "jenkins_server_ip" {
  
}