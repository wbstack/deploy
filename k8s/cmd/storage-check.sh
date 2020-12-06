#!/usr/bin/env bash

echo "Query Service"
PODNAME=$(kubectl get pods -l app.kubernetes.io/name=queryservice -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it $PODNAME -- du -sh //wdqs/data
kubectl exec -it $PODNAME -- ls -lahr //wdqs/data | grep data

echo "SQL Master"
PODNAME=$(kubectl get pods -l release=sql,component=master -o jsonpath="{.items[0].metadata.name}")
kubectl exec -c mariadb -it $PODNAME -- du -sh //bitnami/mariadb

echo "SQL Replica"
PODNAME=$(kubectl get pods -l release=sql,component=slave -o jsonpath="{.items[0].metadata.name}")
kubectl exec -c mariadb -it $PODNAME -- du -sh //bitnami/mariadb


