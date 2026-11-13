#!/usr/bin/env bash
set -Eeuxo pipefail
cd ~/lab5/k8s-27
kubectl apply -f db.yaml
kubectl rollout status deployment/db --timeout=300s
kubectl wait --for=condition=Ready pod -l app=db --timeout=300s
sed -i '/DB_USER:/a\  DB_HOST: "db"' config.yaml
kubectl apply -f config.yaml
kubectl rollout restart deployment/web
kubectl rollout status deployment/web --timeout=300s
sleep 10
for i in 1 2 3; do curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600/visits; done
kubectl delete pod -l app=db
kubectl rollout status deployment/db --timeout=300s
sleep 10
curl -fsS --retry 60 --retry-all-errors --retry-delay 2 localhost:8600/visits
