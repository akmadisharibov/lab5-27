# DevOps Lab 5 — Variant 27

Student: Sharibov. Kubernetes manifests and a Helm chart for Flask and PostgreSQL.

Folders: app/, k8s-27/, lab5-27/. Environment values: values-dev.yaml and values-prod.yaml.
The numbered shell scripts record the lab stages. Run them individually in ~/lab5.
The kind cluster named devops must map NodePort 30080 to 8600 and 30081 to 8601.

## Local credentials
No database credentials or execution logs are committed to this public repository.
Export DB_PASSWORD in your local terminal before executing the configuration and Helm scripts.
Create the Kubernetes Secret at runtime using 02-config.sh. Helm commands pass the same variable
using --set-string db.password="$DB_PASSWORD". The chart deliberately requires that value.
Do not commit your local password, generated Secret output, or report screenshots to this repository.

## Final lab state
Dev: lab5-27-dev, four web replicas, greeting Updated, localhost:8600.
Prod: lab5-27-prod, three web replicas, greeting Salem, localhost:8601.
The dev release history contains a failed image update and rollback.
PostgreSQL is ephemeral for the purpose of demonstrating data loss after Pod replacement.

Reference: https://kind.sigs.k8s.io/docs/user/known-issues/
