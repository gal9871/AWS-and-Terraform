resource "aws_route53_zone" "private" {
  name = "kandula"
  vpc {
    vpc_id = var.vpc_id
  }
}


resource "aws_route53_record" "elk_server" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "elk.kandula"
  type    = "A"
  ttl     = "300"
  records = [var.elk_ip]
}

resource "aws_route53_record" "jenkins_nodes" {
  count   = 2
  zone_id = aws_route53_zone.private.zone_id
  name    = "jenkins${count.index}.kandula"
  type    = "A"
  ttl     = "300"
  records = [var.jenkins_agents_ip[count.index]]
}
resource "aws_route53_record" "grafana_server" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "grafana.kandula"
  type    = "A"
  ttl     = "300"
  records = [var.promcol_prv_ip[0]]
}

resource "aws_route53_record" "prometheus_server" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "prometheus.kandula"
  type    = "A"
  ttl     = "300"
  records = [var.promcol_prv_ip[0]]
}
resource "aws_route53_record" "consul_servers" {
  count   = 3
  zone_id = aws_route53_zone.private.zone_id
  name    = "consul-server${count.index}.kandula"
  type    = "A"
  ttl     = "300"
  records = [var.consul_servers_ip[count.index]]
}

resource "aws_route53_record" "consul_client" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "consul-client.kandula"
  type    = "A"
  ttl     = "300"
  records = [var.consul_client_ip[0]]
}

resource "aws_route53_record" "jenkins_server" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "jenkins.kandula"
  type    = "A"
  ttl     = "300"
  records = [var.jenkins_server_ip]
}

# resource "aws_route53_record" "bastion_server" {
#   zone_id = var.route53_zone_id
#   name    = "bastion.kandula"
#   type    = "A"
#   ttl     = "300"
#   records = []
# }