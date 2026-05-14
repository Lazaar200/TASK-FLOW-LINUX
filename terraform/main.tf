terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Réseau Docker
resource "docker_network" "task_flow_network" {
  name = "task-flow-network"
}

# Conteneur MySQL
resource "docker_container" "db" {
  name  = "terraform_db"
  image = "mysql:8.0"

  env = [
    "MYSQL_ROOT_PASSWORD=root",
    "MYSQL_DATABASE=todolist"
  ]

  networks_advanced {
    name = docker_network.task_flow_network.name
  }

  ports {
    internal = 3306
    external = 3306
  }
}

# Conteneur Backend Laravel
resource "docker_container" "backend" {
  name  = "terraform_backend"
  image = "task-flow-linux-backend"

  env = [
    "APP_ENV=local",
    "APP_DEBUG=true",
    "DB_CONNECTION=mysql",
    "DB_HOST=terraform_db",
    "DB_PORT=3306",
    "DB_DATABASE=todolist",
    "DB_USERNAME=root",
    "DB_PASSWORD=root"
  ]

  networks_advanced {
    name = docker_network.task_flow_network.name
  }

  ports {
    internal = 8000
    external = 8000
  }

  depends_on = [docker_container.db]
}

# Conteneur Frontend
resource "docker_container" "frontend" {
  name  = "terraform_frontend"
  image = "task-flow-linux-frontend"

  networks_advanced {
    name = docker_network.task_flow_network.name
  }

  ports {
    internal = 4200
    external = 4200
  }

  depends_on = [docker_container.backend]
}
