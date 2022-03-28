module "route53" {
    source = "..\\modules\\r53"
    vpc_id = module.main_vpc.aws_vpc_id
    elk_ip = module.elk.public_ip
    jenkins_agents_ip = module.jenkins.jenkins_agent_ip
    promcol_prv_ip    = module.promcol.promcol_prv_ip
    consul_client_ip  = module.promcol.clients_prv
    consul_servers_ip = module.promcol.servers_prv
    jenkins_server_ip = module.jenkins.jenkins_server_ip
}