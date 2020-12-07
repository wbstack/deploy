# Google Cloud

WBStack is deployed to Google Cloud.

The Google Cloud deployment is currently split between the old [gce](./gce) directory and the new [terraform](./tf) directory.

## Installing dependencies

Go to https://console.cloud.google.com/ and download the gcloud SDK.

## Connecting to the project

```sh
gcloud config set project wbstack
gcloud config set compute/zone us-east1-b
```

## Creating the cluster

For WBStack production [deployment manager](https://cloud.google.com/deployment-manager) was used to create the cluster.

This configuration was deleted at some point and deployment manager is being moved away from.

Soon this step will be done in terraform, but for now you just want a cluster that looks something like...

In production this is currently:

- Named as "cluster-1
- 2x e2-medium
- 1x e2-standard-2

## Connecting to the cluster

```sh
gcloud container clusters get-credentials cluster-1
kubectl config set-cluster cluster-1
kubectl get pods --all-namespaces
```

## Reserving a static IP address

For WBStack production [deployment manager](https://cloud.google.com/deployment-manager) was used to create the ip address.

You can find details for this in [the ip directory])(./ip).

The equivalent gcloud command is:

```sh
gcloud compute addresses create main-web-static-ip-us-east1 --project=wbstack --region=us-east1-b
```

## Other things

Once you are this far you have setup the bulk of the underlying stuff.

- [dns](./gce/dns) - Would be needed by cert-manager and generally to access things via domain
- [images](./gce/images) - Has 1 script to keep the image registry clean (we don't even use that now)...
- [serviceaccount](./gce/serviceaccounts) - Create service accounts for various extra things
  - **certman-dns01-solver** - Used by cert-manager to alter DNS records for HTTPS cert creation.
  - **bucket-writer** - TBA? Is this still used?
  - **wbstack-api** - TBA...
- [snapshots](./gce/snapshots) - Sets up snapshot creation for the MYSQL master disk (once the disk is created)
- [storage](./gce/storage) - Sets up a bucket for holding some static files to be served (like logos)
