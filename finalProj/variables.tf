variable "network_info" {
  default = "10.0.0.0/16"
}

variable "prometheus_dir" {
  description = "directory for prometheus binaries"
  default     = "/opt/prometheus"
}

variable "node_exporter_version" {
  description = "Node Exporter version"
  default     = "0.18.1"
}
