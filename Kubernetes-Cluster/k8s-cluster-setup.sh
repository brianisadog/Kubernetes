#!/bin/bash

# Install Kubernetes v1.11.0
sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo bash -c 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" \
    > /etc/apt/sources.list.d/kubernetes.list'
sudo apt-get update
sudo apt-get install -y kubelet=1.11.0-00 kubectl=1.11.0-00 kubeadm=1.11.0-00
sudo systemctl enable kubelet && sudo systemctl start kubelet

# Disable Swap memory
sudo swapoff -a

# Update & Upgrade
sudo apt-get update && sudo apt-get upgrade -y

# Setup cgroup for kubeadm
sudo sed -i "s/kubelet.conf\"/kubelet.conf --cgroup-driver=cgroupfs\"/g" \
    /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo systemctl daemon-reload && sudo systemctl start kubelet

# Setup iptables parameters
sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo sysctl net.bridge.bridge-nf-call-ip6tables=1
sudo sysctl net.ipv4.ip_forward=1
sudo iptables -D INPUT -j REJECT --reject-with icmp-host-prohibited

# Clean up
sudo apt-get autoremove -y
sudo apt-get autoclean -y
