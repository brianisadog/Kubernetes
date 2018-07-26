#!/bin/bash

##########################################
# only need to edit when on master nodes #
##########################################

# main machine ip address
export LOCAL_MACHINE_IP=172.30.144.54

# main machine username
export LOCAL_MACHINE_USERNAME=bsung

# k8s machine ip address
export K8SHA_IPLOCAL=10.106.6.151

# k8s machine hostname, options: kube-master-1, kube-master-2, kube-master-3
export K8SHA_HOSTNAMELOCAL=kube-master-1

# k8s machine etcd name, must use these options: etcd-1, etcd-2, etcd-3
export K8SHA_ETCDNAME=etcd-1

###########################################
# all masters settings below must be same #
###########################################

# master-1 ip address
export K8SHA_IP1=10.106.6.151

# master-2 ip address
export K8SHA_IP2=10.106.6.152

# master-3 ip address
export K8SHA_IP3=10.106.6.153

# master-1 hostname
export K8SHA_HOSTNAME1=kube-master-1

# master-2 hostname
export K8SHA_HOSTNAME2=kube-master-2

# master-3 hostname
export K8SHA_HOSTNAME3=kube-master-3

# master-1 username
export K8SHA_USERNAME1=b

# master-2 username
export K8SHA_USERNAME2=b

# master-3 username
export K8SHA_USERNAME3=b

# docker registry ip address
export K8SHA_DR_IP=10.106.6.157

# kubernetes cluster token, you can use 'kubeadm token generate' to get a new one
export K8SHA_TOKEN=6r709g.kzuup4oswniwgr4h

# kubernetes CIDR pod subnet, if CIDR pod subnet is "10.244.0.0/16" please set to "10.244.0.0\\/16"
export K8SHA_CIDR=10.244.0.0\\/16

# kubernetes CIDR service subnet, if CIDR service subnet is "10.96.0.0/12" please set to "10.96.0.0\\/12"
export K8SHA_SVC_CIDR=10.96.0.0\\/12

# calico network settings, set a reachable ip address for the cluster network interface, for example you can use the gateway ip address
export K8SHA_CALICO_REACHABLE_IP=10.106.6.254

#######################################
# please do not modify anything below #
#######################################

# set parameters for k8s-docker-setup.sh
sed \
-e "s/K8SHA_DR_IP/$K8SHA_DR_IP/g" \
k8s-docker-setup.sh.tpl > k8s-docker-setup.sh

chmod +x k8s-docker-setup.sh

echo 'set parameters for k8s-docker-setup.sh success'

if [[ $HOSTNAME = *"master"* ]]; then
    # set etcd cluster docker-compose.yaml file
    sed \
    -e "s/K8SHA_ETCDNAME/$K8SHA_ETCDNAME/g" \
    -e "s/K8SHA_IPLOCAL/$K8SHA_IPLOCAL/g" \
    -e "s/K8SHA_IP1/$K8SHA_IP1/g" \
    -e "s/K8SHA_IP2/$K8SHA_IP2/g" \
    -e "s/K8SHA_IP3/$K8SHA_IP3/g" \
    etcd/docker-compose.yaml.tpl > etcd/docker-compose.yaml

    echo 'set etcd cluster docker-compose.yaml file success: etcd/docker-compose.yaml'

    # set kubeadm init config file
    sed \
    -e "s/K8SHA_HOSTNAME1/$K8SHA_HOSTNAME1/g" \
    -e "s/K8SHA_HOSTNAME2/$K8SHA_HOSTNAME2/g" \
    -e "s/K8SHA_HOSTNAME3/$K8SHA_HOSTNAME3/g" \
    -e "s/K8SHA_IP1/$K8SHA_IP1/g" \
    -e "s/K8SHA_IP2/$K8SHA_IP2/g" \
    -e "s/K8SHA_IP3/$K8SHA_IP3/g" \
    -e "s/K8SHA_TOKEN/$K8SHA_TOKEN/g" \
    -e "s/K8SHA_CIDR/$K8SHA_CIDR/g" \
    -e "s/K8SHA_SVC_CIDR/$K8SHA_SVC_CIDR/g" \
    kubeadm-init.yaml.tpl > kubeadm-init.yaml

    echo 'set kubeadm init config file success: kubeadm-init.yaml'

    # set canal deployment config file
    sed \
    -e "s/K8SHA_CIDR/$K8SHA_CIDR/g" \
    -e "s/K8SHA_CALICO_REACHABLE_IP/$K8SHA_CALICO_REACHABLE_IP/g" \
    kube-canal/canal.yaml.tpl > kube-canal/canal.yaml

    echo 'set canal deployment config file success: kube-canal/canal.yaml'

    # set parameters for k8s-master-setup.sh
    sed \
    -e "s/K8SHA_IP2/$K8SHA_IP2/g" \
    -e "s/K8SHA_IP3/$K8SHA_IP3/g" \
    -e "s/K8SHA_USERNAME2/$K8SHA_USERNAME2/g" \
    -e "s/K8SHA_USERNAME3/$K8SHA_USERNAME3/g" \
    -e "s/LOCAL_MACHINE_IP/$LOCAL_MACHINE_IP/g" \
    -e "s/LOCAL_MACHINE_USERNAME/$LOCAL_MACHINE_USERNAME/g" \
    k8s-master-setup.sh.tpl > k8s-master-setup.sh

    chmod +x k8s-master-setup.sh

    echo 'set parameters for k8s-master-setup.sh success'
fi
