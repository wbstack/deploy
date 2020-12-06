#!/usr/bin/env bash
# Login to gcloud
# Setup your local docker to be able to pull images from gce

gcloud auth login

gcloud auth configure-docker
