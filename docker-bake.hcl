group "default" {
  targets = ["image-release"]
}

variable "REPO" {
  default = "bubylou/moria"
}

variable "TAG" {
  default = "latest"
}

target "image-dev" {
  inherits = ["image-release"]
  cache-from = ["type=registry,ref=ghcr.io/bubylou/moria"]
  cache-to = ["type=inline"]
  env = {
    "STEAMCMD_VERSION" = "latest"
    "UPDATE_ON_START" = "false"
    "RESET_SEED" = "true"
  }
}

target "image-release" {
  context = "."
  dockerfile = "Dockerfile"
  cache-from = ["type=gha"]
  cache-to = ["type=gha,mode=max"]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/bubylou/moria-docker"
    "org.opencontainers.image.authors" = "Nicholas Malcolm <bubylou@pm.me>"
    "org.opencontainers.image.licenses" = "MIT"
  }
  platforms = ["linux/amd64"]
  tags = ["ghcr.io/${REPO}:latest", "ghcr.io/${REPO}:${TAG}",
          "docker.io/${REPO}:latest", "docker.io/${REPO}:${TAG}"]
}
