resource "aws_instance" "ec2_instance"{
    ami = var.ami.id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.vpc_security_group_ids
    user_data = var.user_data
    tags = var.tags
    key_name = var.key_name
    private_key_path = var.private_key_path
    connection {
        type = "ssh"
        host = self.publlic_ip
        user = "ec2-user"
        private_key = file(var.private_key_path)
    }

    provisioner "remote-exec" {
        inline = [var.inline]
    }
}