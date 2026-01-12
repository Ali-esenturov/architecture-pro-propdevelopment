#!/bin/bash

NAMESPACE=app

kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

kubectl create serviceaccount dev-sa -n $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount functional-sa -n $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount ops-sa -n $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount security-sa -n $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount admin-sa -n $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

echo "ServiceAccount созданы."
