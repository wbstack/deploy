#!/usr/bin/env bash

WBSTACK_KUBECTL="kubectl --context=gke_wbstack_us-east1-b_cluster-1"

echo "Elastic Search"
PODNAME=$($WBSTACK_KUBECTL get pods -l release=elasticsearch -l statefulset.kubernetes.io/pod-name=elasticsearch-master-0 -o jsonpath="{.items[0].metadata.name}")
$WBSTACK_KUBECTL exec -it $PODNAME -- du -sh //usr/share/elasticsearch/data

echo "Query Service"
PODNAME=$($WBSTACK_KUBECTL get pods -l app.kubernetes.io/name=queryservice -o jsonpath="{.items[0].metadata.name}")
$WBSTACK_KUBECTL exec -it $PODNAME -- du -sh //wdqs/data
$WBSTACK_KUBECTL exec -it $PODNAME -- ls -lahr //wdqs/data | grep data

echo "SQL Master"
PODNAME=$($WBSTACK_KUBECTL get pods -l release=sql,component=master -o jsonpath="{.items[0].metadata.name}")
$WBSTACK_KUBECTL exec -c mariadb -it $PODNAME -- du -sh //bitnami/mariadb

echo "SQL Replica"
PODNAME=$($WBSTACK_KUBECTL get pods -l release=sql,component=slave -o jsonpath="{.items[0].metadata.name}")
$WBSTACK_KUBECTL exec -c mariadb -it $PODNAME -- du -sh //bitnami/mariadb
