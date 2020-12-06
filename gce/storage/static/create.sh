#!/usr/bin/env bash

# Create a static bucket for sharing between a few services with public web access..
# Files accessible at for example: https://storage.googleapis.com/wbstack-static/file.txt

gsutil.cmd mb -p wbstack -c STANDARD -l US-EAST1 -b on gs://wbstack-static/
gsutil.cmd iam ch allUsers:objectViewer gs://wbstack-static/
