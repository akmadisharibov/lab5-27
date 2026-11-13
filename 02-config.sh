#!/usr/bin/env bash
set -Eeuxo pipefail
: "${DB_PASSWORD:?Export DB_PASSWORD locally before running this script}"
cd ~/lab5/k8s-27
kubectl apply -f config.yaml
kubectl create secret generic web-secret --from-literal=DB_PASSWORD="$DB_PASSWORD" --dry-run=client -o yaml | kubectl apply -f -
kubectl get configmap web-config -o yaml | head -16
kubectl get secret web-secret -o yaml | grep -A1 '^data'
kubectl get secret web-secret -o jsonpath='{.data.DB_PASSWORD}' | base64 -d; echo
