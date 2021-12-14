resource "kubernetes_persistent_volume_claim" "minio_server" {
  metadata {
    generate_name = "minio-server-"
    namespace     = kubernetes_namespace.minio_server.metadata[0].name
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
  wait_until_bound = false
}
