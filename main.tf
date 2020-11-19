# Demo 1 

provider "google" {
  version = "3.5.0"
  credentials = file("/root/.config/gcloud/application_default_credentials.json")
  project = "psd-devops-coe"
  region  = "europe-west4"
  zone    = "europe-west4-b"
}

# Create VPC 
resource "google_compute_network" "vpc_network" {
  name = "terraform-network-test"
} 

# Data block for image family - used later
data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-1604-lts"
  project = "ubuntu-os-cloud"
}

# Instance creation
resource "google_compute_instance" "my_vm" {
  name         = "tf-test-itai"
  machine_type = "f1-micro"
  tags = ["web"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_image.self_link
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

