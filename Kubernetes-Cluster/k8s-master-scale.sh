#!/bin/bash
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl get deploy -n kube-system
kubectl scale --replicas=2 -n kube-system deployment.apps/coredns
