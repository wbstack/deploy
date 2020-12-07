# Kubernetes

Kubernetes does all of the heavy lifting.

The [k8s directory](./k8s) is split into a few directories.

- [cmd](./k8s/cmd) - Some convenience scripts for interacting with k8s resources once they are created.
- [definitions](./k8s/definitions) - kubernetes files to be applied to the base cluster.
- [helm](./k8s/helm) - helm deployments that need to be deployed.

## Installing dependencies

You need helm version 3+ https://github.com/helm/helm/releases

You need helmfile https://github.com/roboll/helmfile/releases

And you need some helm plugins:

- **diff** - helmfile needs this to diff resources
- **git** - We need this to fetch charts from git (our charts repo is a git repo currently)

```sh
helm plugin install https://github.com/databus23/helm-diff.git
helm plugin install https://github.com/aslafy-z/helm-git
```

## Definitions - Namespaces, Roles and StorageClasses

- 00-namespace-cert-manager.yaml - Create a namespace for cert-manager to operate in.
- 00-secret-creators.yaml - Roles for a secret creation service used in some later services (for creating random services password etc.)
- 00-storageclass-faster.yaml - Creates a SSD based StorageClass we can use (Probably not needed now as created by default)

You can apply these individually, or all together.

```sh
kubectl apply -f ./k8s/00-base/*
```

## Definitions - Custom Resource Definitions

cert-manager needs some custom resources to be defined.

This YAML is taken directory from the cert-manager release, and is held here for convenice (instead of referencing a URL).

```sh
kubectl apply -f ./k8s/01-crds/cert-manager.yaml
```

## Definitions - cert-manager - Certificates

cert-manager should create some certificates once it is running.

These files define the certificates that the kubernetes cluster in general will want.

```sh
kubectl apply -f ./k8s/02-cert-manager*
```

## Helm

All other services are deployed using helm and helmfile.
