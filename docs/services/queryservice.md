scalling up the disk space

To list all existing pvcs:
```
kubectl get pvc -l app=queryservice,release=queryservice
```

Patch individual claims:
```
kubectl patch pvc queryservice -p '{"spec":{"resources":{"requests": {"storage":"10Gi"}}}}'
```
The PVC will then list FileSystemResizePending as a condition.

Once the pod is restarted / recreated the PV will have the increased size.
```
kubectl get pod | grep queryservice
kubectl get pod queryservice-7b9577b659-md22b
kubectl delete pod queryservice-7b9577b659-md22b
```

UPDATE the helmfile values and deploy..
