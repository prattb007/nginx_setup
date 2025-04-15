# Step 1: Create a Cloud Router
resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  region  = "us-east1"
  network = google_compute_network.test-vpc.id
}

# Step 2: Create Cloud NAT
resource "google_compute_router_nat" "nat_config" {
  name                               = "cloud-nat-config"
  router                             = google_compute_router.nat_router.name
  region                             = "us-east1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
