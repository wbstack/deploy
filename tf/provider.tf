provider "google" {
  project = "wbstack"
  region  = "us-east1-b"
}

terraform {
  required_providers {
    google = {
      version = "~> 3.49.0"
    }
  }
}
