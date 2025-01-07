group "default" {
  targets = ["build"]
}

group "release-all" {
  targets = ["release"]
}

variable "REPO" {
  default = "bubylou/moria"
}

variable "TAG" {
  default = "latest"
}
target "build" {
  context = "."
  dockerfile = "Dockerfile"
  cache-from = ["type=registry,ref=ghcr.io/${REPO}"]
  cache-to = ["type=inline"]
  env = {
    "STEAMCMD_VERSION" = "latest"
    "UPDATE_ON_START" = "false"
    "RESET_SEED" = "true"
  }
  tags = ["ghcr.io/${REPO}:latest", "ghcr.io/${REPO}:${TAG}",
          "docker.io/${REPO}:latest", "docker.io/${REPO}:${TAG}"]
}

target "release" {
  inherits = ["build"]
  context = "."
  dockerfile = "Dockerfile"
  cache-from = ["type=gha"]
  cache-to = ["type=gha,mode=max"]
  attest = [
    "type=provenance,mode=max",
    "type=sbom"
  ]
  platforms = ["linux/amd64"]
}
