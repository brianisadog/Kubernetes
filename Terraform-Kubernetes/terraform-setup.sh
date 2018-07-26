#!/bin/bash

# Install Terraform v0.11.7
wget "https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip"
unzip terraform_0.11.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm -f terraform_0.11.7_linux_amd64.zip

# Install Golang v1.10.3
wget "https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz"
sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
source /etc/profile
mkdir -p $HOME/go/src/github.com/sl1pm4t/terraform-provider-kubernetes/
rm -f go1.10.3.linux-amd64.tar.gz

# 2018-07-12: Currently, the official Terraform-K8s-Provider does not support deployment resource yet
# Skip Golang and this if a newer version of Terraform-K8s-Provider supports deployment resource
# Install unofficial Terraform-K8s-Provider included with deployment resource
git clone https://github.com/sl1pm4t/terraform-provider-kubernetes \
    $HOME/go/src/github.com/sl1pm4t/terraform-provider-kubernetes/
make -C $HOME/go/src/github.com/sl1pm4t/terraform-provider-kubernetes/ build \
&& rm -rf $HOME/go/src/github.com/
