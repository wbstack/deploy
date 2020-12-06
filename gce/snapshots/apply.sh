#!/usr/bin/env bash

# Apply the 2 day snapshot schedule to the wbstack SQL master
PVC=$(kubectl get pvc data-sql-mariadb-master-0 -o jsonpath="{.spec.volumeName}")
DISK=$(gcloud compute disks list --filter="${PVC}" --format='get(name)')
LOCATION=$(gcloud compute disks list --filter="${PVC}" --format='value(location())')
gcloud compute disks add-resource-policies ${DISK} --zone=${LOCATION} --resource-policies=wbstack-nightly-east-to-west-2d-1
