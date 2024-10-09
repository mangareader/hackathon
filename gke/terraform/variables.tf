variable "project" {
  type        = string
  description = "gcp project where the cluster will be created"
}
variable "region" {
  type        = string
  description = "gcp region where the resources are being created"
}
variable "zone" {
  type        = string
  description = "gcp zone in the region where the cluster will be created"
}
variable "cluster_name" {
  type        = string
  description = "gke cluster name, same name is used for vpc and subnets"
  default     = "hackathon"
}

variable "k8s_version" {
  type        = string
  description = "k8s version"
  default     = "1.30"
}