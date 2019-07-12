resource "google_container_cluster" "wavefront-proxy" {
  name               = "${var.clustername}"
  zone               = "${var.zone}"
  initial_node_count = 3

  addons_config {
    network_policy_config {
      disabled = true
    }
  }

  master_auth {
    username = "${var.username}"
    password = "${var.password}"
  }

  resource_labels = {
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/compute",
    ]
  }
}

output "client_certificate" {
  value     = "${google_container_cluster.wavefront-proxy.master_auth.0.client_certificate}"
  sensitive = true
}

output "client_key" {
  value     = "${google_container_cluster.wavefront-proxy.master_auth.0.client_key}"
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = "${google_container_cluster.wavefront-proxy.master_auth.0.cluster_ca_certificate}"
  sensitive = true
}

output "host" {
  value     = "${google_container_cluster.wavefront-proxy.endpoint}"
  sensitive = true
}

output "instance_group_urls" {
  value = "${google_container_cluster.wavefront-proxy.instance_group_urls.0}"
}