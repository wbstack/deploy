Scalling up the disk space

TODO next time try just updating the helm value and doing `helmfile apply` as GCE might handle resizing nicely now.

To list all existing pvcs:
```
kubectl get pvc -l app=queryservice,release=queryservice
```

Patch individual claims:
```
kubectl patch pvc queryservice -p '{"spec":{"resources":{"requests": {"storage":"10Gi"}}}}'
```
The PVC will then list FileSystemResizePending as a condition.

After a short period of time on GCE the PVC will have resized
This is different to legacy behavior that required a new pod.
You can check this with:

```
kubectl get pvc queryservice
```

You should see the new disk allocation.

UPDATE the helmfile values and deploy..
