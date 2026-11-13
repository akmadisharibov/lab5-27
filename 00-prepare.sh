#!/usr/bin/env bash
set -Eeuxo pipefail
kubectl config use-context kind-devops
kubectl get nodes
helm version --short
docker ps --format '{{.Names}}'
mkdir -p ~/lab5/app ~/lab5/evidence
cd ~/lab4/lab4-27
for f in app.py requirements.txt Dockerfile .dockerignore; do git show main:$f > ~/lab5/app/$f; done
cd ~/lab5/app
docker build -t lab5-27:1.0 .
kind load docker-image lab5-27:1.0 --name devops
docker image save --platform linux/amd64 -o /tmp/lab5-postgres.tar postgres:16-alpine
docker exec -i devops-control-plane ctr --namespace=k8s.io images import --platform linux/amd64 --no-unpack - < /tmp/lab5-postgres.tar
docker exec devops-control-plane crictl images | grep -E 'lab5|postgres'
