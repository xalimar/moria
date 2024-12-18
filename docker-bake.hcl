group "default" {
  targets = ["main"]
}

variable "REGISTRY" {
  default = "ghcr.io"
}

variable "REPO" {
  default = "bubylou/moria"
}

variable "TAG" {
  default = "v0.2.0"
}

function "tag" {
  params = [tag]
  result = "${REGISTRY}/${REPO}:${tag}"
}

target "main" {
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
  tags = [tag("latest"), tag("${TAG}")]
}
