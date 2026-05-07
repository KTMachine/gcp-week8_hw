# Input variables for Terraform configuration

# Variable for GCP Project ID
variable "project_id" {
  description = "GCP project ID"
  type = string
  default = "invictus-65"
}

# Variable for the region
variable "region" {
  description = "GCP region for the provider and resources"
  type        = string
  default     = "us-central1"
}

# Variable for the zone
variable "zone" {
  description = "GCP zone for the provider and resources"
  type        = string
  default     = "us-central1-a"
}

# Variable for the VM Instance name
variable "vm_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "hw-week8-vm"
}