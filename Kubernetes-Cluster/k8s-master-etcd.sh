#!/bin/bash

# Reset Kubernetes cluster
yes | sudo kubeadm reset
if [[ $HOSTNAME = *"master-1" ]]; then
    sudo rm -rf /etc/kubernetes/pki
    echo "Removed pki from master-1 node."
fi
sudo rm -rf /var/lib/etcd-cluster
docker container rm $(docker container ls -aqf name=etcd) -f
docker-compose --file etcd/docker-compose.yaml up -d
sudo systemctl stop kubelet && sudo systemctl stop docker
sudo rm -rf /var/lib/cni/
sudo rm -rf /var/lib/kubelet/*
sudo rm -rf /etc/cni/
sudo ip link del docker0
sudo ip link del flannel.1
sudo ip link del cni0
sudo systemctl restart docker && sudo systemctl restart kubelet
