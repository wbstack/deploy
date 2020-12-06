#!/usr/bin/env bash

PODNAME=$(kubectl get pods -l app.kubernetes.io/name=nginx,app.kubernetes.io/instance=platform-nginx -o jsonpath="{.items[1].metadata.name}")
kubectl exec -it $PODNAME -- //bin/bash
