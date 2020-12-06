#!/usr/bin/env bash

cd ./sql
helmfile apply
cd ..

cd ./queryservice
helmfile apply
cd ..

cd ./redis
helmfile apply
cd ..

cd ./adminer
helmfile apply
cd ..
