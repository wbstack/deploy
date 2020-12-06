#!/usr/bin/env bash

kubectl port-forward $(kubectl get pod --selector="app.kubernetes.io/instance=queryservice,app.kubernetes.io/name=queryservice" --output jsonpath='{.items[0].metadata.name}') 8080:9999