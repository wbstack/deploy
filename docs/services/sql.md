### Increasing number of slaves

The slave count can be increased in the helmfile and deployed.
The slave will catchup using the binlog (as far as I can tell).
If a volume already exists that the slave will end up mounting (ie, the slave has existed before) then the catchup will be faster.

### Increasing allocated disk space (replica example)

NOTE: This process was last followed on 26th April 2020 and worked fine

Increasing the master or slave disk size in helmfile and applying will FAIL.
Forbidden: updates to statefulset spec for fields other than 'replicas', 'template', and 'updateStrategy' are forbidden.

Statefullsets are not all that modifiable, but one can:
```
# Get the set
kubectl get statefulset sql-mariadb-slave
# Delete the old statefullset, keeping all pods:
kubectl delete statefulset sql-mariadb-slave --cascade=false
# Update the disk allocation in the template of the helmfile.
...
#Apply the helmfile changes, recreating the set
helmfile apply
```

This will not alter previously created pods, but will mean new pods are created with the new settings.

To list all existing pvcs:
```
kubectl get pvc -l app=mariadb,component=slave,release=sql
```

Patch individual claims:
```
kubectl patch pvc data-sql-mariadb-slave-0 -p '{"spec":{"resources":{"requests": {"storage":"66Gi"}}}}'
```

The PVC will then list FileSystemResizePending as a condition.

Once the pod is restarted / recreated the PV will have the increased size.
```kubectl get pod sql-mariadb-slave-0```
```kubectl delete pod sql-mariadb-slave-0```

### Creating a new replica (from another snapshot (replica or master))

Might be useful in the future (beta in 1.17 k8s):
  - https://kubernetes.io/docs/concepts/storage/volume-snapshots/
  - https://kubernetes.io/docs/concepts/storage/volume-snapshots/#provisioning-volumes-from-snapshots

**Instructions**

List the various k8s volumes you could use:

```
kubectl get pvc -l app=mariadb,release=sql
```

Match that up to a gcloud disk:

```
gcloud compute disks list
```

If you are taking a snapshot of a master, you will need to set the DB to readonly for the period, and flush the bin logs, allowing writes again after:

```
# Readonly & flush binlogs
FLUSH TABLES WITH READ LOCK;
SET GLOBAL read_only = ON;
FLUSH BINARY LOGS;

# TAKE A SNAPSHOT HERE

# Allow writes again
SET GLOBAL read_only = OFF;
UNLOCK TABLES;
```

Create a new snapshot from the disk:
```
REPLICA_DISK_TO_COPY=gke-cluster-1-fe044d2c-pvc-fe32db80-f5a2-11e9-8351-42010a8e00b6
SNAPSHOT_NAME=tmp-sql-snapshot-1

gcloud compute disks snapshot \
    ${REPLICA_DISK_TO_COPY} \
    --snapshot-names=${SNAPSHOT_NAME} \
    --project=wbstack --zone=us-east1-b --storage-location=us-east1

```

Restore the snapshot to a temporary volume:
```
SNAPSHOT_NAME=tmp-sql-snapshot-1
SNAPSHOT_SIZE=$(gcloud compute snapshots describe ${SNAPSHOT_NAME} --format=json | jq -r .diskSizeGb) && echo $SNAPSHOT_SIZE

gcloud compute disks create tmp-snapshot-restore-1 \
    --size ${SNAPSHOT_SIZE} \
    --source-snapshot ${SNAPSHOT_NAME} \
    --zone us-east1-b \
    --type pd-ssd
```

Create a replica with a new PVC:

- Increase the replica count so that a new PVC is created (though the pod will fail).
- Decrease the replica count so that the sql instance is gone, but the PVC remains.

List the various k8s volumes and find the one for the new replica:

```
kubectl get pvc -l app=mariadb,release=sql
```

Match that up to a gcloud disk:

```
gcloud compute disks list
```

Create a VM that has both volumes mounted:

```
RESTORE_TO_DISK=gke-cluster-1-fe044d2c-pvc-9e61e14c-1b8d-11eb-b104-42010a8e022c

gcloud compute instances create tmp-snapshot-restore-machine \
    --machine-type=f1-micro \
    --boot-disk-size=10GB \
    --zone=us-east1-b \
    --disk=name=tmp-snapshot-restore-1,mode=ro,device-name=from \
    --disk=name=${RESTORE_TO_DISK},mode=rw,device-name=to
```

Connect to the tmp machine:

```
gcloud compute ssh tmp-snapshot-restore-machine --zone=us-east1-b
```

Mount the devices and copy data:

```
# See the devices
lsblk
# Mount them
sudo mkdir -p /srv/source /srv/target
sudo mount -o ro,noload /dev/sdb /srv/source
sudo mount -o rw /dev/sdc /srv/target
# Copy everything over
# (~8 mins for 16GB disks (13GB full))
# (~14 mins for 30GB disks (15GB full) )
sudo rm -rf /srv/target/*
sudo cp -a /srv/source/. /srv/target/
```

Delete the temp VM (and boot disk):

```
gcloud compute instances delete tmp-snapshot-restore-machine --zone=us-east1-b
```

**If copying from a replica:**

Scale up that replica again (should just work TM)?

**If copying from a master:**

https://dev.mysql.com/doc/mysql-replication-excerpt/5.6/en/replication-howto-slaveinit.html

Alter the replica definition so that the liveness probe is skipped, and replication doesn't start up:

```
slave:
  extraFlags: --skip-slave-start
  livenessProbe:
    enabled: false
```

And scale the replica up!

Compare the list of bin logs on each the actual master and the copy.
The position to start from should be obvious as the master will have started a fresh log once out of readonly.

```
SHOW BINARY LOGS;
```

You can confirm the start position should be 4 with:

```
SHOW BINLOG EVENTS IN 'mysql-bin.000381' LIMIT 10
```

SSH to the replica, and get some details:

```
echo $MARIADB_MASTER_HOST
echo $MARIADB_MASTER_PORT_NUMBER
echo $MARIADB_REPLICATION_USER
echo $MARIADB_REPLICATION_PASSWORD
```

Start the MySql client and make our new replcia start from that place.

```
CHANGE MASTER TO MASTER_HOST='XXX',
MASTER_PORT=3306,
MASTER_USER='XXX',
MASTER_PASSWORD='XXX',
MASTER_CONNECT_RETRY=10,
MASTER_LOG_FILE='XXX',
MASTER_LOG_POS=4;
```

And then start replication and check on the status:

```
START SLAVE;
SHOW SLAVE STATUS\G;
```

You shouldn't see any errors and the replica should catch up!

REMEMBER!!! to scale down so the replica stops and remove `--skip-slave-start` and enable the liveness check.

**TBA cleanup the snapshot and disk used?**

### Cleaning up binlogs (saving replica space?)

https://dba.stackexchange.com/questions/41050/is-it-safe-to-delete-mysql-bin-files#41054

Remove binlogs older than 7 days:

```
PURGE BINARY LOGS BEFORE DATE(NOW() - INTERVAL 7 DAY) + INTERVAL 0 SECOND;
```
