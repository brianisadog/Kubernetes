#!/bin/bash

# Pull Kubernetes basic components
docker pull k8s.gcr.io/kube-apiserver-amd64:v1.11.0
docker pull k8s.gcr.io/kube-proxy-amd64:v1.11.0
docker pull k8s.gcr.io/kube-scheduler-amd64:v1.11.0
docker pull k8s.gcr.io/kube-controller-manager-amd64:v1.11.0
docker pull k8s.gcr.io/pause:3.1
docker pull k8s.gcr.io/coredns:1.1.3
docker pull k8s.gcr.io/etcd-amd64:3.2.18
docker pull gcr.io/google_containers/k8s-dns-sidecar-amd64:1.14.7
docker pull gcr.io/google_containers/k8s-dns-kube-dns-amd64:1.14.7
docker pull gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64:1.14.7

# Pull Kubernetes network add ons
docker pull quay.io/coreos/flannel:v0.9.1-amd64
docker pull quay.io/calico/node:v3.0.3
docker pull quay.io/calico/kube-controllers:v2.0.1
docker pull quay.io/calico/cni:v2.0.1

# Images only required on master nodes
if [[ $HOSTNAME = *"master"* ]]; then
    # Pull Kubernetes dashboard
    docker pull k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3

    # Pull Kubernetes heapster
    docker pull k8s.gcr.io/heapster-influxdb-amd64:v1.3.3
    docker pull k8s.gcr.io/heapster-grafana-amd64:v4.4.3
    docker pull k8s.gcr.io/heapster-amd64:v1.5.3
fi
