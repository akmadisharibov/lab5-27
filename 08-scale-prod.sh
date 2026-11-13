#!/usr/bin/env bash
set -Eeuxo pipefail
: "${DB_PASSWORD:?Export DB_PASSWORD locally before running this script}"
cd ~/lab5
helm upgrade lab5-27-dev lab5-27 -f values-dev.yaml -n lab5-27-dev --set replicaCount=4 --wait --timeout 300s --set-string db.password="$DB_PASSWORD"
kubectl get deployment -n lab5-27-dev
helm get values lab5-27-dev -n lab5-27-dev
for i in {1..12}; do curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600/health >/dev/null; done
kubectl logs -l app=lab5-27-dev -n lab5-27-dev --prefix --tail=2
helm install lab5-27-prod lab5-27 -f values-prod.yaml -n lab5-27-prod --create-namespace --wait --timeout 300s --set-string db.password="$DB_PASSWORD"
curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8601
curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600
helm list -A
kubectl get pods -A | grep lab5
