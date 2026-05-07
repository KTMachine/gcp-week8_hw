# A single VM instance in GCP using Terraform

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = "n2-standard-2"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-10"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["http-server"]

  metadata = {
    startup-script = file("${path.module}/startup-script.sh")
  }

  labels = {
    env = "dev"
  }
}