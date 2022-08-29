terraform {
  required_version = "~> 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.33.0" # pinning version
    }
  }
}

# Define GCP provider
provider "google" {
  region  = var.region
  zone    = var.zone
  project = var.project_name
  # credentials = file(var.gcp_auth_file)
  # project     = var.gcp_project
}
