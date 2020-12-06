#!/usr/bin/env bash

APIPODNAME=$(kubectl get pods -l app.kubernetes.io/name=api -l app.kubernetes.io/component=queue -o jsonpath="{.items[0].metadata.name}")
WIKIDETAILS=$(kubectl exec -it $APIPODNAME -- php artisan app:getWiki domain "$1")


WW_DB_NAME=$(echo $WIKIDETAILS | jq .wiki_db.name)
WW_DB_USER=$(echo $WIKIDETAILS | jq .wiki_db.user)
WW_DB_PASS=$(echo $WIKIDETAILS | jq .wiki_db.password)
WW_DB_HOST="sql-mariadb.default.svc.cluster.local"

echo mysql --host $WW_DB_HOST --database $WW_DB_NAME --user $WW_DB_USER --password
echo $WW_DB_PASS

SQLPODNAME=$(kubectl get pods -l app=mariadb -l release=sql -l component=master -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it $SQLPODNAME -- bash
