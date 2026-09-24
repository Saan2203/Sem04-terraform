terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {}

# Definición de imágenes a utilizar
resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_image" "node" {
  name = "node:18-alpine"
}

resource "docker_image" "postgres" {
  name = "postgres:13-alpine"
}

# ==========================================
# ENTORNO DEV
# ==========================================

resource "docker_container" "bd_dev" {
  name  = "bd-dev"
  image = docker_image.postgres.image_id
  env   = ["POSTGRES_PASSWORD=admindev"]
  ports {
    internal = 5432
    external = 4003
  }
}

resource "docker_container" "api_dev" {
  name  = "api-dev"
  image = docker_image.node.image_id
  # Mapeamos el archivo local al contenedor para que ejecute nuestro código
  upload {
    file       = "/app/index.js"
    content    = file("${path.cwd}/index.js")
  }
  command = ["node", "/app/index.js"]
  ports {
    internal = 3000
    external = 4002
  }
}

resource "docker_container" "web_dev" {
  name  = "web-dev"
  image = docker_image.nginx.image_id
  upload {
    file    = "/usr/share/nginx/html/index.html"
    content = file("${path.cwd}/index.html")
  }
  ports {
    internal = 80
    external = 4001
  }
}

# ==========================================
# ENTORNO QA
# ==========================================

resource "docker_container" "bd_qa" {
  name  = "bd-qa"
  image = docker_image.postgres.image_id
  env   = ["POSTGRES_PASSWORD=adminqa"]
  ports {
    internal = 5432
    external = 5003
  }
}

resource "docker_container" "api_qa" {
  name  = "api-qa"
  image = docker_image.node.image_id
  upload {
    file       = "/app/index.js"
    content    = file("${path.cwd}/index.js")
  }
  command = ["node", "/app/index.js"]
  ports {
    internal = 3000
    external = 5002
  }
}

resource "docker_container" "web_qa" {
  name  = "web-qa"
  image = docker_image.nginx.image_id
  upload {
    file    = "/usr/share/nginx/html/index.html"
    content = file("${path.cwd}/index.html")
  }
  ports {
    internal = 80
    external = 5001
  }
}