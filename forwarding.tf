resource "google_compute_region_backend_service" "internal_lb_backend" {
  name          = "internal-lb-backend"
  region        = var.default_region
  protocol      = "TCP"
  load_balancing_scheme = "INTERNAL"
  health_checks = [google_compute_health_check.default.id]
  # port_name             = "http"


  backend {
    group = google_compute_region_instance_group_manager.mig_internal1.instance_group
    balancing_mode  = "CONNECTION"
    
  }

  backend {
    group = google_compute_instance_group.umig1_internal.self_link
    balancing_mode  = "CONNECTION"
  }

  backend {
    group = google_compute_instance_group.umig2_internal.self_link
    balancing_mode  = "CONNECTION"
  }
}

resource "google_compute_forwarding_rule" "internal" {
  name                  = "internal-lb-rule"
  load_balancing_scheme = "INTERNAL"
  ip_protocol           = "TCP"
  backend_service       = google_compute_region_backend_service.internal_lb_backend.id
  network               = google_compute_network.test-vpc.id
  subnetwork            = google_compute_subnetwork.test-subnet.id
  ports                 = ["80"]
  region                = var.default_region
}
