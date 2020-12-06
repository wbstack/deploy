# terraform

This is pereperatory work for moving to terraform..

Not currently used..

## Installation

You can [install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) using an apt repo.

[Terraformer](https://github.com/GoogleCloudPlatform/terraformer) can also be installed to generate terraform
resources from existing cloud resources.
Be sure to pick the `all` or `google` flavour provider package.

## Initialization

In the tf directory run `terraform init` to initialize terraform.

You'll also need to [create some "Application Default Credentials"](https://myshittycode.com/2019/10/30/gcp-terraform-google-could-not-find-default-credentials-error/) for terraform to use.

```sh
gcloud auth application-default login
```

## Generated from pre existing resources

If when trying to import resources you get [errors about plugins](https://github.com/GoogleCloudPlatform/terraformer/issues/590) you may need to do the following:

```sh
mkdir -p ~/.terraform.d/plugins/
cp -r ./.terraform/providers/registry.terraform.io/hashicorp/google/3.49.0/* ~/.terraform.d/plugins/
```

You can import existing resources with:

```sh
terraformer import google --resources=addresses,dns,firewall,gcs,gke,globalAddresses,healthChecks,httpHealthChecks,httpsHealthChecks,iam,logging,monitoring,project --connect=true --regions=us-east1 --projects=wbstack
```
