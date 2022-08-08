#!/usr/bin/env bash

# Updates the DNS zone based on the ./*-zone files in this repo
gcloud --project=wbstack dns record-sets import ./zone-opencura --zone=opencura-zone --delete-all-existing
gcloud --project=wbstack dns record-sets import ./zone-wbstack --zone=wbstack-zone --delete-all-existing
