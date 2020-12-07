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
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/aslafy-z/helm-git
```

## Definitions

The definitions are static kubernetes YAML files.

It might be nice to try and move all of this to charts to be deployed via helm...

But for now they must be deployed using `kubectl`.

### Namespaces, Roles and StorageClasses

- 00-namespace-cert-manager.yaml - Create a namespace for cert-manager to operate in.
- 00-secret-creators.yaml - Roles for a secret creation service used in some later services (for creating random services password etc.)
- 00-storageclass-faster.yaml - Creates a SSD based StorageClass called 'faster' or use by services that need fast disks.

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

- [cert-manager](./k8s/helm/cert-manager) - Created the cert-manager controller (manages certificates).
- [clusterissuers](./k8s/helm/clusterissuers) - Creates the cert-manager cluster issuers that connect to Let's Encrypt.

**TBA values!**

### sql

We could use an external sql service, but in the interest of depending on as few services as possible, and keeping costs down, this is currently done in k8s.

- [sql](./k8s/helm/sql) - Replication aware sql setup running MariaDB
- [adminer](./k8s/helm/adminer) - Web interface access for sql (OPTIONAL)

Some private values will be needed:

```yml
services:
  sql:
    rootPassword: 'somePassword'
    replicationPassword: 'someOtherPassword'
```

Once the sql service is running we can create some secrets for use by other services.

- [tasks/init-sql-secrets.yaml] - Creates the SQL secrets / password required for various SQL services (and api user and a mediawiki db manager user)
- [tasks/init-sql.yaml] - Creates the SQL users, from the secrets just created, for various SQL services (wait for the first jobs to finish first!!!)

Both of these steps should probably be performed as part of the helm files deploying the services rather than here.

You can find some more docs for interacting with sql in the [docs/services directory](./docs/services).

### redis

We could use an external redis service, but in the interest of depending on as few services as possible, and keeping costs down, this is currently done in k8s.

- [redis](./k8s/helm/redis) - Replicated redis setup for use by services

Some private values will be needed:

```yml
services:
  redis:
    password: somePassword
```

You can find some more docs for interacting with redis in the [docs/services directory](./docs/services).

## Application services

Web facing frontend for the platform app services:

- [platform-nginx](./k8s/helm/platform-nginx) - Nginx ingress doing path based routing
  - Possible modifications:
    - nginx.conf `set_real_ip_from` needs to be set to the range of possible Pod IP addresses
    - nginx.conf `resolver` probably doesn't need adjusting if your using a default looking cluster
  - NOTE: nginx will initially fail as it can't resolve upstream hosts (as we didn't make the services yet)
    - Maybe this should all be done in a different order? OR it shouldn't need the services to exist? and fallback?
- [platform-apps-ingress](./k8s/helm/platform-apps-ingress) - Expose the platform-nginx with an ingress
  - For other usecases this probably needs its own helm charts currently D: (TODO make the chart generic...)

And the platform to manage all the things:

- [api](./k8s/helm/api) (API users already created in the sql step)
- [ui](./k8s/helm/ui)

And the app services themselves:

- [mediawiki135](./k8s/helm/mediawiki135)
- [mediawiki134](./k8s/helm/mediawiki134) (Currently still needed for a OAuth issue with some tools)
- [queryservice](./k8s/helm/queryservice)
- [queryservice-gateway](./k8s/helm/queryservice-gateway)
- [queryservice-updater](./k8s/helm/queryservice-updater)
- [queryservice-ui](./k8s/helm/queryservice-ui)
- [tool-quickstatements](./k8s/helm/tool-quickstatements)
- [tool-widar](./k8s/helm/tool-widar)
- [tool-cradle](./k8s/helm/tool-cradle)