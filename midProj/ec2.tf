# resource "aws_launch_configuration" "example" {
#   image_id = "ami-033b95fb8079dc481"
#   instance_type = "t2.micro"
#   key_name      = "galsekey"
#   security_groups = [module.bastio-sg.aws_security_group_id]
#   subnet_id = module.public_subnet_2.aws_subnet_id
#   provisioner "file" {
#     source      = "jenkins_kp.pem"
#     destination = "/home/ec2-user/jenkins_kp.pem"
#     connection {
#         type     = "ssh"
#         user     = "ec2-user"       
#         private_key = "${file("galsekey.pem")}"
#         timeout = "2m"
#         agent = false
#     }
#   }
#   provisioner "file" {
#     source      = "galsekey.pem"
#     destination = "/home/ec2-user/galsekey.pem" 
#     connection {
#         type     = "ssh"
#         user     = "ec2-user"       
#         private_key = "${file("galsekey.pem")}"
#         timeout = "2m"
#         agent = false
#     }
#   }
#     provisioner "file" {
#     source      = "jenkins-master.pem"
#     destination = "/home/ec2-user/jenkins-master.pem" 
#     connection {
#         type     = "ssh"
#         user     = "ec2-user"       
#         private_key = "${file("galsekey.pem")}"
#         timeout = "2m"
#         agent = false
#     }
#   }
# }