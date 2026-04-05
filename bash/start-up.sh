#!/bin/bash
sudo yum update -y

sudo yum install -y \
	yum-utils \
	git \
	curl
sudo yum-config-manager \
	--add-repo \
	https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermode -aG docker ec2-user

docker --version
git --version
