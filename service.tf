resource "kubernetes_service" "minio_server" {
  metadata {
    generate_name = "minio-server-"
    namespace     = kubernetes_namespace.minio_server.metadata[0].name
  }

  spec {
    port {
      name        = "server"
      port        = 9000
      target_port = "server"
    }
    port {
      name        = "console"
      port        = 9001
      target_port = "console"
    }

    selector = {
      app = "minio-server"
    }
  }
}
