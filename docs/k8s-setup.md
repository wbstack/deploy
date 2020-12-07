**Create the pre requisites**

Some things like IAM and roles etc are needed before the cluster can fully work.

You will find these in the gce directory and all can be deployed using Google deployment manager.

See gce.md for more info..

**Create the cluster**

The cluster is managed using Google deployment manager.

If you are in a new location / have a new public IP that is not yet trusted,
then add it to the cluster definition and update the cluster using deployment manager.

Then you can simply run the create (or update) commands.
You can find help for these in the gce directory.

**Configure the GCE k8s cluster**

First the definitions needs to be applied.
These should be applied in batches (the numbered directories) from lowest to highest.
For example:

```
kubectl apply -f ./00-base
...
```

The order is important as things in batch 00 and used in batch 01 etc.
If they are all applied at the same time things might not run totally smoothly.

**Setup Helm**

In the k8s helm directory run:

```
./init0-helm.sh
```

Note: this is not a yet as secure a helm as it could be...

**Setup various services**

In order:
```
./init1-clusterservices.sh
./init2-dataservices.sh
```

If this is first setup SQL will need to be populated with some data...
TODO this should be part of the helmchart?!
In the tasks directory run:
```
kubectl apply -f ./init-sql-secrets.yaml
```
Wait and make sure the Pods run and populate some secrets.
Then:
```
kubectl apply -f ./init-sql.yaml
```

Then setup the application layer from the helm directory:
```
./init3-appservices.sh
```

### Draining a node

First do something like:
```
kubectl drain gke-cluster-1-e2-small-pool-7830ca18-cx1v
```

It will likely complain about some local data and daemonsets, so you'll probably have to add:
```
--delete-local-data --ignore-daemonsets
```

WARNING: of course, check which pods are using those things first and if tis is actually safe...
