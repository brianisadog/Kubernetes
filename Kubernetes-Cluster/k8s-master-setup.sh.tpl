#!/bin/bash
mkdir -p output && rm -f output/*

# Initialize Kubernetes cluster and output info
sudo kubeadm init --config=kubeadm-init.yaml | tee output/kubeadm-init.log
cat output/kubeadm-init.log | grep "kubeadm join" > output/kubeadm-join

# Make kubectl work for normal user
mkdir -p $HOME/.kube
yes | sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
yes | sudo chown $(id -u):$(id -g) $HOME/.kube/config

# On kube-master-1:
if [[ $HOSTNAME = *"master-1" ]]; then
    # Setup pod-network: Canal
    kubectl apply -f kube-canal/ --validate=false

    # Setup dashboard and heapster
    kubectl taint nodes --all node-role.kubernetes.io/master-
    kubectl apply -f kube-dashboard/
    kubectl apply -f kube-heapster/influxdb/
    kubectl apply -f kube-heapster/rbac/
    kubectl -n kube-system describe secret \
    $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}') \
    > output/dashboard-token

    # Copy kubeadm keys to kube-master-2, kube-master-3, and local machine
    sudo scp -r /etc/kubernetes/pki K8SHA_USERNAME2@K8SHA_IP2:~/
    ssh -t K8SHA_USERNAME2@K8SHA_IP2 'sudo cp -r ~/pki /etc/kubernetes/; rm -rf ~/pki'
    sudo scp -r /etc/kubernetes/pki K8SHA_USERNAME2@K8SHA_IP3:~/
    ssh -t K8SHA_USERNAME2@K8SHA_IP3 'sudo cp -r ~/pki /etc/kubernetes/; rm -rf ~/pki'
    sudo scp -r /etc/kubernetes/pki/* LOCAL_MACHINE_USERNAME@LOCAL_MACHINE_IP:~/.kube/keys/
fi
