GCE or Google Compute Engine? is what we are using for hosting.

#### Troubleshooting

You might need to log in:

```
gcloud auth login
```

### Initial setup (in theroy) of the cluster

Project service account extra roles (*@cloudservices.gserviceaccount.com):
 - resourcemanager.projectIamAdmin, Needed to assign iam roles to users / account
  - https://github.com/GoogleCloudPlatform/deploymentmanager-samples/tree/master/community/cloud-foundation/templates/iam_member
 - iam.roleAdmin, Needed to create custom roles
  - https://github.com/GoogleCloudPlatform/deploymentmanager-samples/tree/master/community/cloud-foundation/templates/iam_custom_role
