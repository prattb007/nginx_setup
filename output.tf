

output "internal_ip" {
  value = google_compute_forwarding_rule.internal.ip_address
}

