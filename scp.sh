#!/bin/bash

# Copy files that we are going to use to setup K8s nodes
# For this example, my nodes are on 10.106.6.151-156
# This is were you need to type a lot of passwords if you don't use SSH Key-Based Authentication
for ip in 10.106.6.{151..156}
do
    scp -r Kubernetes-Cluster/ "username@${ip}:~/"
done
