# resource "google_compute_region_backend_service" "internal_lb_backend" {
#   name                  = "internal-lb-backend"
#   region                = var.default_region
#   protocol              = "TCP"
#   load_balancing_scheme = "INTERNAL"
#   health_checks         = [google_compute_health_check.default.id]
#   port_name             = "http"  # <--- Important

#   backend {
#     group          = google_compute_region_instance_group_manager.mig_internal.instance_group
#     balancing_mode = "CONNECTION"
#   }

#   backend {
#     group          = google_compute_instance_group.umig1_internal.self_link
#     balancing_mode = "CONNECTION"
#   }

#   backend {
#     group          = google_compute_instance_group.umig2_internal.self_link
#     balancing_mode = "CONNECTION"
#   }
# }

