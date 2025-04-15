
resource "google_compute_instance" "umig1_internal" {
  name         = "umig1-internal"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.test-subnet.id
  }

  tags = ["allow-health-check", "allow-iap"]
}

resource "google_compute_instance_group" "umig1_internal" {
  name      = "umig1-internal"
  zone      = "us-east1-b"
  instances = [google_compute_instance.umig1_internal.self_link]
  # network   = google_compute_network.test-vpc.id

  named_port {
    name = "http"
    port = 80
  }

  depends_on = [google_compute_instance.umig1_internal] 
}

resource "google_compute_instance" "umig2_internal" {
  name         = "umig2-internal"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.test-subnet.id
  }

  tags = ["allow-health-check", "allow-iap"]
}

resource "google_compute_instance_group" "umig2_internal" {
  name      = "umig2-internal"
  zone      = "us-east1-b"
  instances = [google_compute_instance.umig2_internal.self_link]
  # network   = google_compute_network.test-vpc.id

  named_port {
    name = "http"
    port = 80
  }

  depends_on = [google_compute_instance.umig2_internal]
}



