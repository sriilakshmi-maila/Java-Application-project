#!/bin/bash
apt-get update -y
apt-get install -y curl wget unzip git openjdk-17-jdk maven

curl -fsSL https://docker.com -o get-docker.sh && sh get-docker.sh
systemctl start docker && systemctl enable docker

wget -O- https://hashicorp.com | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt-get update && apt-get install terraform -y

wget -qO - https://github.io | gpg --dearmor | tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://github.io $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/trivy.list
apt-get update && apt-get install trivy -y

docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community
docker run -d --name grafana -p 3000:3000 grafana/grafana:latest
docker run -d --name prometheus -p 9090:9090 prom/prometheus:latest
