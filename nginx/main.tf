# Start the NGINX+ Container
resource "docker_container" "NginxPlusWebApp" {
  name  = "NginxPlusWebApp"
  image = "nginx-plus:36v4"
  ports {
    internal = "${lookup(var.int_port, var.env)}"
    external = "${lookup(var.ext_port, var.env)}"
    ip = "${lookup(var.ext_ip_Web, var.env)}"
  }
  ports {
    internal = "${var.int_port_TLS}"
    external = "${var.ext_port_TLS}"
    ip = "${lookup(var.ext_ip_Web, var.env)}"
  }
  restart = "always"
  dns = ["172.17.0.1"]
  dns_search = ["lab.local"]
  hostname = "WebApp"
  privileged = "true"
  host {
    host = "controller.lab.local"
    ip = "10.1.20.11"
  }
}

resource "docker_container" "NginxPlusAPI" {
  name  = "NginxPlusAPI"
  image = "nginx-plus:36v4"
  ports {
    internal = "${lookup(var.int_port, var.env)}"
    external = "${lookup(var.ext_port, var.env)}"
    ip = "${lookup(var.ext_ip_API, var.env)}"
  }
  ports {
    internal = "${var.int_port_TLS}"
    external = "${var.ext_port_TLS}"
    ip = "${lookup(var.ext_ip_API, var.env)}"
  }
  restart = "always"
  dns = ["172.17.0.1"]
  dns_search = ["lab.local"]
  hostname = "API"
  privileged = "true"
  host {
    host = "controller.lab.local"
    ip = "10.1.20.11"
  }
}


