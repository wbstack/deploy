#!/usr/bin/env bash
# Uploads any updated copies of files in /static to the bucket

gsutil cp -r ./assets gs://wbstack-static/

echo "Check at: https://console.cloud.google.com/storage/browser/wbstack-static?forceOnBucketsSortingFiltering=false&folder=true&organizationId=true&project=wbstack"
