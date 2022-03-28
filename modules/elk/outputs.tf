output "public_ip" {
  value = module.ec2-instance.private_ip[0]
}
output "kibana_url" {
  value = "http://${module.ec2-instance.public_ip[0]}:5601"
}

output "elk_server_id" {
  value = module.ec2-instance.id[0]
}