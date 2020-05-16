#!/bin/bash

## create Kind cluster
kind delete cluster
kind create cluster --config ./yaml/kind-cluster.yml --image lenhattan86/kind-node:1.8.0-beta.2
# kind create cluster

## label node-0 to zone 0, ...
kubectl label nodes kind-worker zone=0
kubectl label nodes kind-worker2 zone=1
kubectl get nodes --show-labels

##
echo ""
kubectl create -f yaml/pod-0.yml
kubectl create -f yaml/pod-1.yml
kubectl create -f yaml/pod-2.yml

##
kubectl create -f yaml/statefulset.yml
##
sleep 10
## 
kubectl get pods -o wide