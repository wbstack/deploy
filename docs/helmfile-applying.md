###Applying helmfiles

When applying a helmfile you need to be in the directory of the helmfile.

Always look at the diff first:

```
helmfile diff
```

Then if the changes look good:

```
helmfile apply
```
