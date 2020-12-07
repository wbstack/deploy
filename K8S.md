# Kubernetes

Kubernetes does all of the heavy lifting.

The [k8s directory](./k8s) is split into a few directories.

- [cmd](./k8s/cmd) - Some convenience scripts for interacting with k8s resources once they are created.
- [definitions](./k8s/definitions) - kubernetes files to be applied to the base cluster.
- [helm](./k8s/helm) - helm deployments that need to be deployed.

## Namespaces, Roles and StorageClasses

```sh
kubectl apply -f ./k8s/00-base/*
```

## Custom Resource Definitions

cert-manager needs some custom resources to be defined:

```sh
kubectl apply -f ./k8s/01-crds/*
```

## cert-manager - Certificates

State that cert-manager should create some certificates once it is running

```sh
kubectl apply -f ./k8s/02-cert-manager*
```
