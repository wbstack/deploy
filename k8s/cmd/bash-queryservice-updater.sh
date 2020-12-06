#!/usr/bin/env bash

PODNAME=$(kubectl get pods -l app.kubernetes.io/name=queryservice-updater -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it $PODNAME -- //bin/bash
