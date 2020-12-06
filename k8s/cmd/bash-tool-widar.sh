#!/usr/bin/env bash

PODNAME=$(kubectl get pods -l app.kubernetes.io/name=tool-widar -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it $PODNAME -- //bin/bash
