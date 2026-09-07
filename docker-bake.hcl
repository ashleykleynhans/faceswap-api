variable "REGISTRY" {
    default = "docker.io"
}

variable "REGISTRY_USER" {
    default = "ashleykza"
}

variable "APP" {
    default = "faceswap-api"
}

variable "RELEASE" {
    default = "2.1.0"
}

variable "CU_VERSION" {
    default = "130"
}

variable "CUDA_VERSION" {
    default = "13.0.3"
}

variable "TORCH_VERSION" {
    default = "2.14.0"
}

target "default" {
    dockerfile = "Dockerfile"
    tags = ["${REGISTRY}/${REGISTRY_USER}/${APP}:${RELEASE}"]
    annotations = [
        "org.opencontainers.image.title=FaceSwap API",
        "org.opencontainers.image.description=GPU-accelerated face swapping API with 14 models, CodeFormer restoration, and VRAM-safe serial queue",
        "org.opencontainers.image.version=${RELEASE}",
        "org.opencontainers.image.vendor=ashleykleynhans",
        "org.opencontainers.image.source=https://github.com/ashleykleynhans/${APP}",
    ]
    attest = [
        "type=provenance,mode=max",
        "type=sbom",
    ]
    args = {
        CUDA_VERSION = "${CUDA_VERSION}"
        INDEX_URL = "https://download.pytorch.org/whl/cu${CU_VERSION}"
        TORCH_VERSION = "${TORCH_VERSION}+cu${CU_VERSION}"
    }
}
