

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }


    nginx = {
      source  = "getstackhead/nginx"
      version = "1.3.2"
    }
	

  }

}

provider "docker" {
  # Configuration options
}


