provider "kubernetes" {
}


####################################
#    Deploy App3                 ###
####################################

resource "kubernetes_deployment" "app3" {
  metadata {
    name = "app3"
    labels = {
      app = "app3"
    }
  }

  spec {
    replicas = 1

  selector {
      match_labels = {
        app = "app3"
      }
    }

    template {
      metadata {
        labels = {
          app = "app3"
        }
      }

      spec {
        container {
          image = "registry.gitlab.com/arcadia-application/app3/app3:latest"
          name  = "app3"
          image_pull_policy = "IfNotPresent"
          
          port {
            container_port = "80"
           }
	
 }
        }
      }
    }
}

resource "kubernetes_service" "app3" {
  metadata {
    name = "app3"
    labels {
      app = "app3"
      service = "app3"
    }
  }
  spec {
    selector = {
      app = "app3"
    }
    port {
      port        = 80
      target_port = 80
      node_port = 31662
    }

    type = "NodePort"
  }
}
