#!/bin/sh

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

sudo usermod -aG docker $USER
# sudo usermod -aG docker ubuntu
sudo systemctl daemon-reload
sudo systemctl restart docker

sudo apt-get -y autoremove

# Download and install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Deploy irida_galaxy using docker-compose
sudo docker-compose -f stack.yml up --build -d

