#!/bin/bash

if ! [ -z $1 ] && [ $1 == "master" ]; then
    kubectl delete node kube-worker-1
    kubectl delete node kube-worker-2
    kubectl delete node kube-worker-3
    kubectl delete node kube-master-1
    kubectl delete node kube-master-2
    kubectl delete node kube-master-3
fi

yes | sudo kubeadm reset
