# Configure the Google Cloud provider
!terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
}

# Configure the Google Cloud provider
provider "google" {
  project = "gcp-project-id"  # Replace with your GCP project ID
  region  = "us-central1"      # Replace with your desired region
  # zone    = "us-central1-a"      # Optional: Replace with your desired zone (if you need a specific zone)
}

# Create a Compute Engine VM instance
resource "google_compute_instance" "default" {
  name         = "my-vm-instance"
  machine_type = "e2-medium" # Customize your machine type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # Customize your image
    }
  }

  network_interface {
    network = "default" # Using the default network
    # Optional: Assign an external IP address
    access_config {
    }
  }
  #Allow http and https
  allow_stopping_for_update = true
  service_account{
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Output the VM's external IP address (if assigned)
output "vm_external_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
  description = "External IP address of the VM"
}

#Output internal IP
output "vm_internal_ip" {
  value = google_compute_instance.default.network_interface[0].network_ip
  description = "Internal IP address of the VM"
}
