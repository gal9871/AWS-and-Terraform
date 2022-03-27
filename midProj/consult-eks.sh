#!/bin/bash
#terraform apply -auto-approve && \
aws eks update-kubeconfig --region us-east-1 --name kandula-prod && \
kubectl create secret generic consul-gossip-encryption-key --from-literal=key="uDBV4e+LbFW3019YKPxIrg==" && \
helm install consul hashicorp/consul -f values.yaml && \
CONSULIP=$(kubectl get svc consul-consul-dns | tail -1 |awk '{ print $3 }') && \
sed -i -e "s/CONSULIP/${CONSULIP}/g" configmap.yaml && \
kubectl apply -f configmap.yaml && \
sed -i -e "s/${CONSULIP}/CONSULIP/g" configmap.yaml && \
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
helm repo update && \
helm install promcolk8s prometheus-community/kube-prometheus-stack && \
kubectl apply -f filebeat.yaml 
#cd /var/lib/cloud/instance/scripts/