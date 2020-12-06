#!/usr/bin/env bash

PODNAME=$(kubectl get pods -l app.kubernetes.io/name=mediawiki,app.kubernetes.io/instance=mediawiki-135,app.kubernetes.io/component=app-alpha -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it $PODNAME -- //bin/bash
