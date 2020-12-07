# deploy

All WBStack deployment code.

There are docs of varying quality in the [docs](./docs) folder.

Base infrastructure:

- [gce (Google Cloud)](./gce) - Various bash cli snippets for setting up infrastructure (Migrating from this to terraform).
- [tf (Terraform)](./tf) - Infrastructure as code on Google Cloud (Migrating from gce directory to this).

Service deployments:

- [k8s (Kubernetes)](./k8s) - Code and scripts for setting up and interacting with a Kubernetes cluster.