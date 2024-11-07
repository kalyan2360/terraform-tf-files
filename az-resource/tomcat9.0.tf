

resource "docker_image" "ubuntu_9_0_1" {
  name = "ubuntu"
}

resource docker_image nginx_image {
        name = "nginx:latest"
}


resource "docker_container" "my-custom-image" {
  name  = "custom-image1-2"
  image = docker_image.ubuntu_9_0_1.image_id
  ports {
    internal = 8090 # (internal port)accessing the ubuntu image container outside the container
    external = 8082 # (externam port )accessing the ubuntu image container inside the container
  }

  command = ["sleep","500"]
}

resource "docker_container" "nginx_container" {
  name  = "nginx_server"
  image = docker_image.nginx_image.image_id
  ports {
    internal = 8091   # Port in the container
    external = 8081 # Port on the host machine
  }
}

