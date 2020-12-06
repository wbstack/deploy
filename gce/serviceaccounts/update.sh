#!/usr/bin/env bash

gcloud deployment-manager deployments update serviceaccount-certman-dns01-solver --async --config ./serviceaccount.certman-dns01-solver.yaml
gcloud deployment-manager deployments update serviceaccount-bucket-writer --async --config ./bucket-writer.yaml
gcloud deployment-manager deployments update serviceaccount-wbstack-api --async --config ./wbstack-api.yaml
