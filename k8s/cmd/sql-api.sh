#!/usr/bin/env bash

WW_DB_HOST="sql-mariadb.default.svc.cluster.local"

echo "mysql --host $WW_DB_HOST --database apidb --user <user> --password"
echo "<password>"

SQLPODNAME=$(kubectl get pods -l app=mariadb -l release=sql -l component=master -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it $SQLPODNAME -- bash
