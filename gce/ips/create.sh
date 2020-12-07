#!/usr/bin/env bash

# Create an IP address based on the deployentmanager YAML.-
gcloud deployment-manager deployments create ips --config ./ips.yaml
