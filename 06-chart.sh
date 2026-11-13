#!/usr/bin/env bash
set -Eeuxo pipefail
: "${DB_PASSWORD:?Export DB_PASSWORD locally before running this script}"
kubectl delete namespace lab5-27 --wait=true
cd ~/lab5
helm lint lab5-27 --set-string db.password="$DB_PASSWORD"
helm template lab5-27-dev lab5-27 -f values-dev.yaml > /tmp/lab5-rendered.yaml --set-string db.password="$DB_PASSWORD"
head -35 /tmp/lab5-rendered.yaml
helm install lab5-27-dev lab5-27 -f values-dev.yaml -n lab5-27-dev --create-namespace --wait --timeout 300s --set-string db.password="$DB_PASSWORD"
helm list -n lab5-27-dev
kubectl get pods,svc -n lab5-27-dev
curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600
sleep 8
curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600/visits
