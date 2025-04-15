resource "google_compute_network" "test-vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "test-subnet" {
  name          = "test-subnet"
  region        = var.default_region
  network       = google_compute_network.test-vpc.id
  ip_cidr_range = "10.0.0.0/16"
}


resource "google_compute_subnetwork" "test-subnet1" {
  name          = "test-subnet1"
  region        = var.default_region
  network       = google_compute_network.test-vpc.id
  ip_cidr_range = "192.168.0.0/16"
}


resource "google_compute_firewall" "allow-health-check" {
  name    = "allow-health-check"
  network = google_compute_network.test-vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80"] # match your health check port
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  direction     = "INGRESS"
  target_tags   = ["allow-health-check"] # match what you use in your VMs
}

resource "google_compute_firewall" "allow_internal_lb" {
  name    = "allow-internal-lb"
  network = google_compute_network.test-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["10.0.0.0/8"]  # Adjust to your subnet's CIDR
  target_tags   = ["allow-health-check"]
}


resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.test-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["allow-iap"]
}