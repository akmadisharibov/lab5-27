#!/usr/bin/env bash
set -Eeuxo pipefail
: "${DB_PASSWORD:?Export DB_PASSWORD locally before running this script}"
cd ~/lab5
sed -i 's/greeting: Dev/greeting: Updated/' values-dev.yaml
helm upgrade lab5-27-dev lab5-27 -f values-dev.yaml -n lab5-27-dev --wait --timeout 300s --set-string db.password="$DB_PASSWORD"
curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600
if helm upgrade lab5-27-dev lab5-27 -f values-dev.yaml -n lab5-27-dev --set image.tag=9.9 --wait --timeout 60s; then echo 'Unexpected successful invalid image upgrade'; exit 1; fi
kubectl get pods -n lab5-27-dev
curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600
helm history lab5-27-dev -n lab5-27-dev
helm rollback lab5-27-dev 2 -n lab5-27-dev --wait --timeout 300s
kubectl get pods -n lab5-27-dev
curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600
helm history lab5-27-dev -n lab5-27-dev
