
variable "project_name" {
  description = "project name in gcp"
  default     = ""
  type        = string
}

variable "region" {
  description = "region for google cloud"
  default     = "us-central1"
  type        = string
}
variable "zone" {
  description = "zone for cks-master and cks-worker"
  default     = "us-central1-a"
  type        = string
}

variable "machine_type" {
  description = "size of vm"
  type        = string
  default     = "e2-medium"
}

variable "machine_base_image" {
  description = "base image to use for creating VM"
  type        = string
  default     = "ubuntu-2004-focal-v20220419"
}

variable "machine_disk_size" {
  description = "boot disk size of VM in GB"
  type        = number
  default     = 50
}
