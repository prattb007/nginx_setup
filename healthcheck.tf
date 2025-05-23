resource "google_compute_health_check" "default" {
  name = "tcp-health-check"

  tcp_health_check {
    port = 80
  }

  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
}
