resource "aws_security_group" "security_group"{
    name = var.name
    description = var.description
    vpc_id = var.vpc_id
    ingress = var.ingress
    egress = var.egress
    
}