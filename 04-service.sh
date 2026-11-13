#!/usr/bin/env bash
set -Eeuxo pipefail
cd ~/lab5/k8s-27
kubectl apply -f service.yaml
kubectl get svc,endpoints
curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600
for i in {1..12}; do curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600/health >/dev/null; done
kubectl logs -l app=web --prefix --tail=3
