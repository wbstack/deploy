#!/usr/bin/env bash

PODNAME=$(kubectl get pods -l app=nginx-ingress,app.kubernetes.io/component=controller -n kube-system -o jsonpath="{.items[0].metadata.name}")
kubectl exec -n kube-system -it $PODNAME -- //bin/bash
