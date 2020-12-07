All services that have custom images are currently held in the images directory.
Each directory represents a service and contains a Dockerfile and other things needed to build.

In the images directory you can find a collection of build-*.sh files which can be used to build images.

 -l = local build (local)
 -g = gcloud build (prod)

local and gcloud images are built with different names.

### Locally pulling gcloud images

In order to pull gcloud built images to a local machine.
 - Read https://cloud.google.com/container-registry/docs/advanced-authentication
 - gcloud auth configure-docker
 - docker pull gcr.io/open-cura/mediawiki:1.33-0.1
