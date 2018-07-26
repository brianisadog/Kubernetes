#!/bin/bash

# Install docker v17.03.1
DOCKER_VERSION=17.03.1~ce-0~ubuntu-xenial
sudo apt-get -y remove docker docker-engine
sudo apt-get -y install apt-transport-https ca-certificates curl
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce=${DOCKER_VERSION}

# Install docker-compose v1.21.2
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) \
    > ./docker-compose
chmod +x ./docker-compose
sudo mv ./docker-compose /usr/local/bin/docker-compose

# Open docker insecure-registries access
sudo chown -R $USER:$(id -gn $USER) /etc/default/docker
sudo chown -R $USER:$(id -gn $USER) /etc/docker
if ! grep -q "insecure-registry" /etc/default/docker; then
    echo "DOCKER_OPTS=\"--insecure-registry K8SHA_DR_IP:5000\"" >> /etc/default/docker
    echo "{" > /etc/docker/daemon.json
    echo "    \"insecure-registries\" : [\"K8SHA_DR_IP:5000\"]" >> /etc/docker/daemon.json
    echo "}" >> /etc/docker/daemon.json
fi
sudo systemctl daemon-reload && sudo systemctl enable docker && sudo systemctl start docker

# Setup user permission for using docker
sudo usermod -aG docker ${USER}
newgrp docker
