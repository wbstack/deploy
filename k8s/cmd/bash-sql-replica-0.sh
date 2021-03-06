#!/usr/bin/env bash

PODNAME=$(kubectl get pods -l release=sql,component=slave -o jsonpath="{.items[0].metadata.name}")
kubectl exec -c mariadb -it $PODNAME -- //bin/bash
