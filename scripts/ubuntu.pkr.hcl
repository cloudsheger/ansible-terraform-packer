# Example Packer configuration
source "docker" "ubuntu" {
  image = "ubuntu:latest"
}

build {
  sources = ["source.docker.ubuntu"]
}
