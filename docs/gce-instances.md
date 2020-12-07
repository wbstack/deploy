## Current instance types to select from (and current usage)

**e2-small**
 - 2 CPUs (0.5 fractional) - 1.93 allocatable
 - 2 GB memory - 1.45 allocatable (loss of 0.56)
 - 2 Gbps Network
 - $12.23 Regular
 - $3.67 Preemptible

**e2-medium** x1
 - 2 CPUs (1 fractional) - ??? 1.93 allocatable
 - 4 GB memory - ??? 3.45 allocatable? (loss of ????)
 - 2 Gbps Network
 - $24.46 Regular
 - $7.34 Preemptible

**e2-standard-2** x1
 - 2 CPUs - 1.93 allocatable
 - 8 GB memory - 6.36 allocatable (loss of 1.64)
 - 1 Gbps Network
 - $48.92 Regular
 - $14.67 Preemptible

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
