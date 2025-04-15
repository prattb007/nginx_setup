variable "project_id" {
  type = string
  default = "gkelearnings-453911"
}

variable "default_region" {
  default = "us-east1"
}
variable "network_name" {
  default = "custom-network"
}

variable "default_region1" {
  default = "us-central1"
}

variable "zone1" {
  description = "Zone for the instance group"
  type        = string
  default     = "us-east1-b"
}

