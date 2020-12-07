Before you start interacting with the infrastructure you need some command line tools

### Required client command line tools

**gcloud**
 - https://cloud.google.com/sdk/
 - Includes kubectl

**docker**

**helm (version 3)**
https://github.com/helm/helm/releases

 - With plugins
   - For helmfile
     - https://github.com/databus23/helm-diff
     - helm plugin install https://github.com/databus23/helm-diff.git
     - helm plugin install https://github.com/aslafy-z/helm-git

**helmfile**
 - https://github.com/roboll/helmfile/releases

### Getting setup

You probably need to run these:
 - /gce/login.sh
 - /gce/project.sh
 - /gce/kubectl/sync.sh
