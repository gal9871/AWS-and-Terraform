output "sg-id" {
  value = aws_security_group.opsschool_consul.id
}

output "consul_server_instance_id" {
  value = aws_instance.consul_server.*.id
}