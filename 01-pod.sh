#!/usr/bin/env bash
set -Eeuxo pipefail
kubectl create namespace lab5-27
kubectl config set-context --current --namespace=lab5-27
cd ~/lab5/k8s-27
kubectl apply -f pod.yaml
kubectl wait --for=condition=Ready pod/web-27 --timeout=300s
kubectl get pods
kubectl port-forward pod/web-27 8090:5000 >/tmp/lab5-pf.log 2>&1 &
pf=$!
sleep 3
curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8090
kill "$pf"
kubectl delete pod web-27
kubectl get pods
