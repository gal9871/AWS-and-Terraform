output "sg-id" {
  value = aws_security_group.opsschool_consul.id
}

output "consul_server_instance_id" {
  value = aws_instance.consul_server.*.id
}

output "consul_sg" {
  value = aws_security_group.opsschool_consul.id
}

output "consul_role" {
  value = aws_iam_instance_profile.consul-join.name
}

output "prometheus_server_id" {
  value = aws_instance.promcol.id
}