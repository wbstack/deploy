#!/usr/bin/env bash

gcloud deployment-manager deployments create managedzone-wbstack --config ./managedzone-wbstack.yaml
gcloud deployment-manager deployments create managedzone-opencura --config ./managedzone-opencura.yaml
