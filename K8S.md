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

## Definitions

The definitions are static kubernetes YAML files.

It might be nice to try and move all of this to charts to be deployed via helm...

But for now they must be deployed using `kubectl`.

### Namespaces, Roles and StorageClasses

- 00-namespace-cert-manager.yaml - Create a namespace for cert-manager to operate in.
- 00-secret-creators.yaml - Roles for a secret creation service used in some later services (for creating random services password etc.)
- 00-storageclass-faster.yaml - Creates a SSD based StorageClass we can use (Probably not needed now as created by default)

You can apply these individually, or all together.

```sh
kubectl apply -f ./k8s/00-base/*
```

### Custom Resource Definitions

cert-manager needs some custom resources to be defined.

This YAML is taken directory from the cert-manager release, and is held here for convenice (instead of referencing a URL).

```sh
kubectl apply -f ./k8s/01-crds/cert-manager.yaml
```

### cert-manager - Certificates

cert-manager should create some certificates once it is running.

These files define the certificates that the kubernetes cluster in general will want.

```sh
kubectl apply -f ./k8s/02-cert-manager*
```

## Helm

All other services are deployed using helm and helmfile.

When applying a helmfile you need to be in the directory of the helmfile.

Always look at the diff first with `helmfile diff`.
You can then actually apply the changes with `helmfile apply`.

### Infrastructure services

These services are generally shared and used by multiple components.

They do not really add to / are part of the deployed application at all.

#### ingress-nginx

Values should probably be defined in the chart, but for now they live here..

The one thing we might need to change is the IP?

```yml
controller:
  service:
    loadBalancerIP: <IP Address>
```

#### cert-manager

Some cert-manager things were already deployed in the Definitions stages of this guide.

cert-manager also has 2 sets of helmfiles to deploy.

- [cert-manager](./k8s/cert-manager) - Created the cert-manager controller (manages certificates).
- [clusterissuers](./k8s/clusterissuers) - Creates the cert-manager cluster issuers that connect to Let's Encrypt.

### sql

We could use an external sql service, but in the interest of depending on as few services as possible, and keeping costs down, this is currently done in k8s.

- [sql](./k8s/sql) - Replication aware sql setup running MariaDB
- [adminer](./k8s/adminer) - Web interface access for sql(OPTIONAL)

Once the sql service is running we can create some secrets for use by other services.

- [tasks/init-sql-secrets.yaml] - Creates the SQL secrets / password required for various SQL services (and api user and a mediawiki db manager user)
- [tasks/init-sql.yaml] - Creates the SQL users, from the secrets just created, for various SQL services

Both of these steps should probably be performed as part of the helm files deploying the services rather than here.

### redis

We could use an external redis service, but in the interest of depending on as few services as possible, and keeping costs down, this is currently done in k8s.

- [redis](./k8s/redis) - Replicated redis setup for use by services

## Application services

Web facing frontend for the platform app services:

- [platform-nginx](./k8s/platform-nginx) - Nginx ingress doing path based routing
- [platform-apps-ingress](./k8s/platform-apps-ingress) - Expose the platform-nginx with an ingress 

And the app services themsevles:

- [mediawiki135](./k8s/mediawiki135)
- [mediawiki134](./k8s/mediawiki134) (Currently still needed for a OAuth issue with some tools)
- [queryservice](./k8s/queryservice)
- [queryservice-gateway](./k8s/queryservice-gateway)
- [queryservice-ui](./k8s/queryservice-ui)
- [tool-quickstatements](./k8s/tool-quickstatements)
- [tool-widar](./k8s/tool-widar)
- [tool-cradle](./k8s/tool-cradle)

And the platform to manage it all:

- [api](./k8s/api) (API users already created in the sql step)
- [ui](./k8s/ui)
