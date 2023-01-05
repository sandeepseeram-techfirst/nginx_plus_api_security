provider "kubernetes" {
}

####################################
#    Deploy Main App             ###
####################################

resource "kubernetes_deployment" "main" {
  metadata {
    name = "main"
    labels = {
      app = "main"
    }
  }

  spec {
    replicas = 1

  selector {
      match_labels = {
        app = "main"
      }
    }

    template {
      metadata {
        labels = {
          app = "main"
        }
      }

      spec {
        container {
          image = "registry.gitlab.com/arcadia-application/main-app/mainapp:latest"
          name  = "main"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = "80"
           }

 }
        }
      }
    }
}

resource "kubernetes_service" "main" {
  metadata {
    name = "main"
    labels  {
      app = "main"
      service = "main"
    }
  }
  spec {
    selector = {
      app = "main"
    }
    port {
      port        = 80
      target_port = 80
      node_port = 30511
    }

    type = "NodePort"
  }
}

####################################
#    Deploy BackEnd              ###
####################################

resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend"
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = 1

  selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          image = "registry.gitlab.com/arcadia-application/back-end/backend:latest"
          name  = "backend"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = "80"
           }

 }
        }
      }
    }
}

resource "kubernetes_service" "backend" {
  metadata {
    name = "backend"
    labels  {
      app = "backend"
      service = "backend"
    }
  }
  spec {
    selector = {
      app = "backend"
    }
    port {
      port        = 80
      target_port = 80
      node_port = 31584
    }

    type = "NodePort"
  }
}
