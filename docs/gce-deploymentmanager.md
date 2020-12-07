deployment-manager is not really used in wbstack any more.... So this might all be retired soon.

For the areas that use deployment-manager you'll need to do commands like this:

```
gcloud deployment-manager deployments create cluster --config ./dm/cluster.yaml
gcloud deployment-manager deployments describe cluster
gcloud deployment-manager deployments update cluster --config ./dm/cluster.yaml
```

### Docs
 - Resource types: https://cloud.google.com/deployment-manager/docs/configuration/supported-resource-types
 - Deployment manager examples: https://github.com/GoogleCloudPlatform/deploymentmanager-samples
 - gcloud deployment-manager ref: https://cloud.google.com/sdk/gcloud/reference/deployment-manager/
 - Updating deployment: https://cloud.google.com/deployment-manager/docs/deployments/updating-deployments

### Links
 - Deployment manager dashboard: https://console.cloud.google.com/dm/deployments?project=wbstack
