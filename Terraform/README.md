# Terraform Written Explanations

## Mandatory Arguments for a Google Compute Enginge VM in Terraform
```
- You can start by going to registry.terraform.io

- Click "browse" on the right > Providers > Google Cloud Platform

- Click on Documentation

- On the left search for "google_compute_instance"

- Scroll down or cmd+f to find the resource
```

## Resource found
```
Mandatory arguments

- name: Identifies the VM within the project and zone
- machine_type: Defines the CPU
- zone: The zone where the instance will be located
- boot_disk: Where you will have decided the image and size
- network interface: The VPC and Subnets that you have connected to you VM instance
```

## Output for Internal and External IP Addresses
When creating your output.tf file, you can reference the finished resources from your created VM Instance in Terraform 
```
output "internal_ip" {
  value = google_compute_instance.vm.network_interface[0].network_ip
}

output "external_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}
```