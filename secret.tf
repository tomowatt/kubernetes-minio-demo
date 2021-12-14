resource "random_password" "minio_root" {
  length  = 64
  lower   = true
  upper   = true
  special = true
  number  = true
}

resource "kubernetes_secret" "minio_server" {
  metadata {
    generate_name = "minio-server-"
    namespace     = kubernetes_namespace.minio_server.metadata[0].name
  }

  data = {
    MINIO_ROOT_USER     = "root"
    MINIO_ROOT_PASSWORD = random_password.minio_root.result
  }
}