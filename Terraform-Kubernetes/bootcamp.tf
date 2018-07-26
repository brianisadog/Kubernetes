resource "kubernetes_namespace" "bootcamp-namespace" {
  metadata {
    annotations {
      name = "bootcamp-namespace"
    }

    name = "bootcamp"
  }
}

resource "kubernetes_deployment" "bootcamp-deployment" {
  metadata {
    name = "bootcamp-deployment"
    namespace = "bootcamp"
    labels {
      app = "bootcamp"
    }
  }

  spec {
    replicas = "12"
    selector {
      app = "bootcamp"
    }

    template {
      metadata {
        labels {
          app = "bootcamp"
        }
      }

      spec {
        container {
          image = "jocatalin/kubernetes-bootcamp:v1"
          image_pull_policy = "IfNotPresent"
          name  = "bootcamp"

          port {
            container_port = "8080"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "bootcamp-service" {
  metadata {
    name = "bootcamp-service"
    namespace = "bootcamp"
  }
  spec {
    selector {
      app = "bootcamp"
    }

    external_ips = ["10.106.6.151", ]

    port {
      name = "bootcamp-http"
      port = "8080"
      target_port = "8080"
    }

    type = "NodePort"
  }
}
