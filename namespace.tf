resource "kubernetes_namespace" "minio_server" {
  metadata {
    name = "minio-server"
  }
}