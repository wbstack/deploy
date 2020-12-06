#!/usr/bin/env bash

gcloud compute resource-policies create snapshot-schedule wbstack-nightly-east-to-west-2d-1 \
--project=wbstack --region=us-east1 \
--max-retention-days=2 \
--on-source-disk-delete=keep-auto-snapshots \
--daily-schedule \
--start-time=00:00 \
--storage-location=us-west1 \
--description=A\ Nightly\ snapshot\ that\ is\ retained\ for\ 2\ days\ from\ the\ east\ to\ the\ west\ coast\ of\ the\ US.$'\n'Snapshots\ kept\ on\ disk\ deletion.
