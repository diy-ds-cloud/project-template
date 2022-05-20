variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "diy_project_name" {
  description = "diy project name"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.diy_project_name}-gke"
  location = var.region
  remove_default_node_pool = false
  initial_node_count       = var.gke_num_nodes
}