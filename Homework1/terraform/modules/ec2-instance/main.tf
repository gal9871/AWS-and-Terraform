resource "aws_instance" "ec2_instance"{
    ami = var.ami.id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.vpc_security_group_ids
    user_data = var.user_data
    tags = var.tags
}