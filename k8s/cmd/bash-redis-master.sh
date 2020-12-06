#!/usr/bin/env bash

PODNAME=$(kubectl get pods -l app=redis,role=master -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it $PODNAME -- //bin/bash
