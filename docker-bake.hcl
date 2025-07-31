variable "ASEPRITE_UPSTREAM" { default = "docker-image://ghcr.io/kidthales/aseprite:headless-v1.3.14.4" }
variable "IMAGES_PREFIX" { default = "gdtk:" }
variable "IMAGES_TAG" { default = "latest" }
variable "TILED_VERSION" { default = "1.11.2" }

function "tag" {
    params = [name]
    result = ["${IMAGES_PREFIX}${name}-${IMAGES_TAG}"]
}

target "toolkit" {
    args = { tiled_version = "${TILED_VERSION}" }
    labels = null
    tags = tag("toolkit")
}

target "with-aseprite" {
    contexts = {
        aseprite-upstream = "${ASEPRITE_UPSTREAM}"
        toolkit = "target:toolkit"
    }
    dockerfile = "Dockerfile.ase"
    labels = null
    tags = tag("with-aseprite")
}

group "default" {
    targets = ["toolkit"]
}
