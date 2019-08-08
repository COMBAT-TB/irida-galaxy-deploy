#!/usr/bin/env bash

# Script to deploy dockerised versions of IRIDA and Galaxy using docker-compose

# Remove older versions if installed 
sudo apt-get remove docker docker-engine docker.io containerd runc

# Install required packages
sudo apt-get install -y --install-recommends \
    linux-generic-hwe-16.04 \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get -y update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# sudo usermod -aG docker $USER
sudo usermod -aG docker ubuntu

# https://docs.openstack.org/project-deploy-guide/kolla-ansible/ocata/quickstart.html#build-container-images
sudo bash -c 'cat << EOF > /etc/docker/daemon.json
{
  "mtu": 1450
}
EOF'
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo cat /etc/docker/daemon.json

sudo apt-get -y autoremove

# Download and install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# deploy irida_galaxy using docker-compose
sudo docker-compose up --build -d

