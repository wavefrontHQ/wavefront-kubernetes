resource "kubernetes_service" "wavefront-service" {
  metadata {
    name = "${var.service_context}"
  }

  spec {
    selector = {
      app = "${var.context}"
    }
    port {
      name = "wavefront"
      protocol = "TCP"
      port = 2878
      target_port = 2878
    }
  }
}

resource "kubernetes_deployment" "wavefront-proxy-deployment" {
  metadata {
    name = "${var.context}"
    labels = {
      app = "${var.context}"
    }
}
  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "${var.context}"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.context}"
        }
      }

      spec {
        container {
            image = "${var.image}"
            name  = "${var.context}"
            env {                      
              name  = "WAVEFRONT_URL"
              value = "<URL>"
            }
            env {
              name  = "WAVEFRONT_TOKEN"
              value = "<TOKEN>"
            }
            port {
              container_port = 2878
            }
        }
        container {
            image = "wavefronthq/telegraf-sidecar:latest"
            name  = "telegraf"
            env {
              name = "WAVEFRONT_PROXY"
              value = "127.0.0.1"
            }
            env {
              name = "WAVEFRONT_PROXY_PORT"
              value = "2878"
            }
            env {
              name = "INTERVAL"
              value = "60s"
            }
            env {
              name = "METRIC_SOURCE_NAME"
              value = "${var.context}"
            }
            env {
              name = "POD_NAME"
              value = "telegraf-proxy"
            }
            env {
              name = "NAMESPACE"
              value = "default"   
            }
            env {
              name = "NODE_HOSTNAME"
              value = "${var.context}"
            }
            port {
              name = "udp-statsd"
              container_port = 8125
            }
            port {
              name = "udp-8092"
              container_port = 8092
            }
            port {
              name = "tcp-8094"
              container_port = 8094
            }
            volume_mount {
              name = "telegraf-d"
              mount_path = "/etc/telegraf/telegraf.d"
            }  
            security_context {
              run_as_user = 2
              allow_privilege_escalation = false
            }
          }
          volume {
            name = "telegraf-d"
            config_map {
              name = "${kubernetes_config_map.config.metadata.0.name}"
          }
        }  
      }
    }
  }
}

resource "kubernetes_config_map" "config" {
  metadata {
    name = "telegraf-config"
  }
  data = {<CONFIGMAP HERE>} 
}