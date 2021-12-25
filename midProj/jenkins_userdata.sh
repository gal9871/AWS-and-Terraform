#!/bin/bash
sudo yum update -y
sudo yum install docker git java-1.8.0 -y
sudo service docker start
sudo usermod -aG docker ec2-user
sudo yum -y install java-1.8.0-openjdk git
