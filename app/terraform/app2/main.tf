provider "kubernetes" {
}


####################################
#    Deploy App2                 ###
####################################

resource "kubernetes_deployment" "app2" {
  metadata {
    name = "app2"
    labels = {
      app = "app2"
    }
  }

  spec {
    replicas = 1

  selector {
      match_labels = {
        app = "app2"
      }
    }

    template {
      metadata {
        labels = {
          app = "app2"
        }
      }

      spec {
        container {
          image = "registry.gitlab.com/arcadia-application/app2/app2:latest"
          name  = "app2"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = "80"
           }

 }
        }
      }
    }
}

resource "kubernetes_service" "app2" {
  metadata {
    name = "app2"
    labels {
      app = "app2"
      service = "app2"
    }
  }
  spec {
    selector = {
      app = "app2"
    }
    port {
      port        = 80
      target_port = 80
      node_port = 30362
    }

    type = "NodePort"
  }
}
