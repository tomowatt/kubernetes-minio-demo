resource "kubernetes_deployment" "minio_server" {
  metadata {
    generate_name = "minio-server-"
    namespace     = kubernetes_namespace.minio_server.metadata[0].name
  }

  spec {
    selector {
      match_labels = {
        app = "minio-server"
      }
    }
    template {
      metadata {
        labels = {
          app = "minio-server"
        }
        annotations = {
          "secret-data-sha" = sha256(jsonencode(kubernetes_secret.minio_server.data))
        }
      }
      spec {
        volume {
          name = "server-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.minio_server.metadata[0].name
          }
        }
        container {
          name  = "minio-server"
          image = "quay.io/minio/minio"
          args  = ["server", "/data", "--console-address", ":9001"]
          port {
            name           = "server"
            container_port = 9000

          }
          port {
            name           = "console"
            container_port = 9001
          }
          volume_mount {
            name       = "server-data"
            mount_path = "/data"
          }
          env_from {
            secret_ref {
              name = kubernetes_secret.minio_server.metadata[0].name
            }
          }
        }
      }
    }
  }
}

