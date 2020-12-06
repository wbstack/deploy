#!/usr/bin/env bash

gcloud deployment-manager deployments create serviceaccount-certman-dns01-solver --config ./serviceaccount.certman-dns01-solver.yaml
gcloud deployment-manager deployments create serviceaccount-bucket-writer --config ./bucket-writer.yaml
gcloud deployment-manager deployments create serviceaccount-wbstack-api --config ./wbstack-api.yaml
