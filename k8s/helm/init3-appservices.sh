#!/usr/bin/env bash

cd ./platform-nginx
helmfile apply
cd ..

cd ./queryservice-gateway
helmfile apply
cd ..

cd ./queryservice-ui
helmfile apply
cd ..

cd ./mediawiki
helmfile apply
cd ..

cd ./api
helmfile apply
cd ..

cd ./ui
helmfile apply
cd ..

cd ./tool-cradle
helmfile apply
cd ..

cd ./tool-quickstatements
helmfile apply
cd ..

cd ./tool-widar
helmfile apply
cd ..
