OpsSchool Mid-Project - by Gal Segal

https://docs.google.com/presentation/d/1mMGt79E7gFhoXVnV48EtzSQIr9tWnLsGfvwVGZ8vpAI/edit?usp=sharing

**Overview**
Infrastructure is deployed using Terraform on AWS:

- 1 main VPC
- 2 Private Subnets
- 2 Public Subnets
- backend state is handled on S3 bucket
- "Application" Load balancer targeting & exposing instances:
  - 3 Consul Servers & 1 Consul Agent (port 8500)
- EKS-Kubernetes cluster:
  - 2 groups / 2 nodes each.
  - deployments of the Kandula web-app, running on ELB LoadBalancer - using Flask listening on port 5000.

**Pre-Requisites**

1. Terraform, AWS-CLI, Kubectl, Docker, Python3, Python-Pip, AWS account configured, Github account configured
2. Bash environment to run terraform.
3. Secret named prod/kandula/creds with ID:AWSACCESSID, KEY:AWSSECRETKEY configured.

**Installation & Usage**

1. git clone https://github.com/gal9871/AWS-and-Terraform
2. cd midProj/
4. terraform init
5. terraform apply --auto-approve

Access Jenkins Master: jenkins_server public-ip:8080
Access Consul ui: Load Balancer app-lb DNS hostname (will redirect to /ui)

**Jenkins**
deployed with IAM Role, all required permissions { ec2:Describe\*, eks:DescribeCluster, secretsmanager:GetSecretValue }

JenkinsJobs:

1. create-ami-image: create a snapshot from ebs > register AMI for 'latest' > deRegister old 'image - to always have a "golden image".

2. devops-pipeline-run-docker: Git clone -> Application Test -> Docker build & push to DockerHub -> prepare EKS -> Apply Deployment & Service yaml files. 
