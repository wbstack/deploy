#!/usr/bin/env bash

cd ./cert-manager
helmfile apply
cd ..

cd ./clusterissuers
helmfile apply
cd ..

cd ./ingress-nginx
helmfile apply
cd ..
