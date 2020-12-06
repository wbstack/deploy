#!/usr/bin/env bash

# Updates the DNS zone based on the ./*-zone files in this repo
gcloud dns record-sets export ./zone-opencura --zone=opencura-zone
gcloud dns record-sets export ./zone-wbstack --zone=wbstack-zone
