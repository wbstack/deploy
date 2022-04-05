# deploy

All WBStack deployment code.

You can read a blog post summary of this repo and how it has worked over the years https://addshore.com/2022/04/infrastructure-as-code-for-wbstack-deployments/

Documentation is being built [here](https://wbstack.github.io/docs/tech/)

Some older docs of varying quality live in the [docs](./docs) folder.

- This repository is suplimented by a private repository for some values and files.
- [gce (Google Cloud)](./gce) - Manipulated via various [simple scripts](./gce) and [Terraform](./tf).`
- [k8s (Kubernetes)](./k8s) - [Code and scripts](./k8s) for setting up and interacting with a Kubernetes cluster.
  - [cmd](./k8s/cmd) - Some convenience scripts for interacting with k8s resources once they are created.
  - [definitions](./k8s/definitions) - kubernetes files to be applied to the base cluster.
  - [helm](./k8s/helm) - helm deployments that need to be deployed.
