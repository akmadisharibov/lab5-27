#!/usr/bin/env bash
set -Eeuxo pipefail
cd ~/lab5/k8s-27
kubectl apply -f deployment.yaml
kubectl rollout status deployment/web --timeout=300s
kubectl get deployment,pods
old=$(kubectl get pods -l app=web -o jsonpath='{.items[0].metadata.name}')
kubectl delete pod "$old"
kubectl rollout status deployment/web --timeout=300s
kubectl get pods
sed -i 's/GREETING: .*/GREETING: "Updated"/' config.yaml
kubectl apply -f config.yaml
kubectl exec deploy/web -- printenv GREETING
kubectl rollout restart deployment/web
kubectl rollout status deployment/web --timeout=300s
kubectl exec deploy/web -- printenv GREETING
kubectl rollout history deployment/web
