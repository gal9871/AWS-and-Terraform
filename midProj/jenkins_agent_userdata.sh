#!/usr/bin/env bash

chmod +x /home/ubuntu/sh.sh
./sh.sh

# #!/usr/bin/env bash
# set -e

# ### set consul version
# CONSUL_VERSION="1.8.5"

# echo "Grabbing IPs..."
# PRIVATE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

# echo "Installing dependencies..."
# apt-get -qq update &>/dev/null
# apt-get -yqq install unzip dnsmasq &>/dev/null

apt-get update
apt-get install -y awscli
apt-get install -y openjdk-8-jdk

#docker
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get install -y docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io

sudo apt install -y python3-pip

sudo apt-get install -y python3-venv

#kubectl install
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# echo "Configuring dnsmasq..."
# cat << EODMCF >/etc/dnsmasq.d/10-consul
# # Enable forward lookup of the 'consul' domain:
# server=/consul/127.0.0.1#8600
# EODMCF

# systemctl restart dnsmasq

# cat << EOF >/etc/systemd/resolved.conf
# [Resolve]
# DNS=127.0.0.1
# Domains=~consul
# EOF

# systemctl restart systemd-resolved.service

# echo "Fetching Consul..."
# cd /tmp
# curl -sLo consul.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip

# echo "Installing Consul..."
# unzip consul.zip >/dev/null
# chmod +x consul
# mv consul /usr/local/bin/consul

# # Setup Consul
# echo "Installing Consul1..."
# mkdir -p /opt/consul
# mkdir -p /etc/consul.d
# mkdir -p /run/consul
# tee /etc/consul.d/config.json > /dev/null <<EOF
# {
#   "advertise_addr": "$PRIVATE_IP",
#   "data_dir": "/opt/consul",
#   "datacenter": "opsschool",
#   "encrypt": "uDBV4e+LbFW3019YKPxIrg==",
#   "disable_remote_exec": true,
#   "disable_update_check": true,
#   "leave_on_terminate": true,
#   "retry_join": ["provider=aws tag_key=consul_server tag_value=true"],
#   "enable_script_checks": true,
#   "server": false
# }
# EOF

# # Create user & grant ownership of folders
# echo "Installing Consul2..."
# useradd consul
# chown -R consul:consul /opt/consul /etc/consul.d /run/consul


# # Configure consul service
# echo "Installing Consul3..."
# tee /etc/systemd/system/consul.service > /dev/null <<"EOF"
# [Unit]
# Description=Consul service discovery agent
# Requires=network-online.target
# After=network.target

# [Service]
# User=consul
# Group=consul
# PIDFile=/run/consul/consul.pid
# Restart=on-failure
# Environment=GOMAXPROCS=2
# ExecStart=/usr/local/bin/consul agent -pid-file=/run/consul/consul.pid -config-dir=/etc/consul.d
# ExecReload=/bin/kill -s HUP $MAINPID
# KillSignal=SIGINT
# TimeoutStopSec=5

# [Install]
# WantedBy=multi-user.target
# EOF

# echo "Installing Consul4..."
# systemctl daemon-reload
# systemctl enable consul.service
# systemctl start consul.service

# cat > jenkins.json << EOF
# {
#     "name": "jenkins",
#     "tags": [
#       "cicd",
#       "jenkins"
#     ]
# }
# EOF
# echo "Installing Consul5..."

# echo "Installing Consul6..."
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# apt-get install -y \
#     ca-certificates \
#     curl \
#     gnupg \
#     lsb-release
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# apt-get update
# apt-get install -y docker-ce docker-ce-cli containerd.io

# #Install python pip
# apt install -y python3-pip

# pip3 install virtualenv
# apt-get install -y python3-venv

# curl -X PUT -d @jenkins.json http://localhost:8500/v1/agent/service/register ;echo

# exit 0
