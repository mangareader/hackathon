# setup google provider
# the environment variables below will be set before invoking the module
# GOOGLE_CREDENTIALS - path/to/service/account/credentials/file
# GOOGLE_PROJECT - google project id where the resources need to be created
provider "google" {}

# invoke cluster module which creates vpc, subnet and gke cluter with a default worker nodepool
module "enabled_google_apis" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 16.0"

  project_id                  = var.project
  disable_services_on_destroy = false

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "gkehub.googleapis.com",
    "anthosconfigmanagement.googleapis.com"
  ]
}

module "gke" {
  source             = "terraform-google-modules/kubernetes-engine/google"
  version            = "~> 33.0"
  project_id         = module.enabled_google_apis.project_id
  name               = var.cluster_name
  region             = var.region
  zones              = [var.zone]
  kubernetes_version = var.k8s_version
  network            = "default"
  subnetwork         = "default"
  ip_range_pods      = ""
  ip_range_services  = ""

    node_pools = [
    {
      name                        = "worker"
      machine_type                = "e2-medium"
      node_locations              = var.zone
      min_count                   = 1
      max_count                   = 5
      spot                        = false
      disk_size_gb                = 100
      disk_type                   = "pd-standard"
      image_type                  = "COS_CONTAINERD"
     
    },
  ]
}