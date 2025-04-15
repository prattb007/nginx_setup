

resource "google_compute_instance_template" "nginx_internal" {
  name_prefix   = "nginx-int-template"
  machine_type  = "e2-micro"
  tags          = ["allow-health-check", "allow-iap"]

  disk {
    auto_delete  = true
    boot         = true
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.test-subnet.id
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y nginx

    cat <<EOF > /etc/nginx/sites-available/default
    server {
      listen 80 default_server;
      listen [::]:80 default_server;

      location /health {
          return 200 'healthy';
          add_header Content-Type text/plain;
      }

      location / {
          root /var/www/html;
          index index.html index.htm;
      }
  }
  EOF
    systemctl start nginx
    systemctl enable nginx
  EOT

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_instance_group_manager" "mig_internal1" {
  name               = "mig-east1-int1"
  region             = var.default_region
  base_instance_name = "nginx-int"
  version {
    instance_template = google_compute_instance_template.nginx_internal.self_link
  }
  target_size = 2

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.default.self_link
    initial_delay_sec = 120
  }

  update_policy {
    type           = "OPPORTUNISTIC"
    minimal_action = "REPLACE"
    max_surge_fixed = 100
  }
}



