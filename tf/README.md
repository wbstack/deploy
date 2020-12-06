# terraform

This is preparatory work for moving to terraform..

Not currently used..

## Installation

You can [install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) using an apt repo.

You will need to use version 12 currently:

```sh
sudo apt install terraform=0.12.29
```

[Terraformer](https://github.com/GoogleCloudPlatform/terraformer) can also be installed to generate terraform
resources from existing cloud resources.
Be sure to pick the `all` or `google` flavour provider package.

## Initialization

In the tf directory run `terraform init` to initialize terraform.

You'll also need to [create some "Application Default Credentials"](https://myshittycode.com/2019/10/30/gcp-terraform-google-could-not-find-default-credentials-error/) for terraform to use.

```sh
gcloud auth application-default login
```

## Syncing deployment

You can apply the current configuration (allowing viewing of any changes) byt running the following:

```sh
terraform apply
```

## Generated from pre existing resources

If when trying to import resources you get [errors about plugins](https://github.com/GoogleCloudPlatform/terraformer/issues/590) you may need to do the following:

```sh
mkdir -p ~/.terraform.d/plugins/
cp -r ./.terraform/providers/registry.terraform.io/hashicorp/google/3.49.0/* ~/.terraform.d/plugins/
```

Currently terraform is not used for many resources.
You can import the ones terraform is used for with:

```sh
terraformer import google --resources=monitoring --connect=true --regions=us-east1 --projects=wbstack
cp ./generated/google/wbstackmonitoring/us-east1/
```

You can import more existing resources with something like this:

```sh
terraformer import google --resources=addresses,dns,firewall,gcs,gke,globalAddresses,healthChecks,httpHealthChecks,httpsHealthChecks,iam,logging,monitoring,project --connect=true --regions=us-east1 --projects=wbstack
```
