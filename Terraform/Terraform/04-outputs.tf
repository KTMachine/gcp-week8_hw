output "internal_ip" {
  description = "Internal (private) IP assigned by the VPC subnet"
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
}

output "external_ip" {
  description = "External (public) ephemeral IP via access_config"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}