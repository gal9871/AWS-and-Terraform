resource "aws_ebs_volume" "example" {
     availability_zone = var.availability_zone
     size             = var.size
}

resource "aws_volume_attachment" "ebs_att" {
     device_name = "/dev/sdh"
     volume_id   = var.volume_id
     instance_id = var.instance_id
}