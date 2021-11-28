terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
  }
}

locals {
  images = [
    {
      name  = "foo"
      image = "alpine"
    },
    {
      name  = "bar",
      image = "debian"
    },
  ]

  lists = []
}

resource "helm_release" "example" {
  name       = "my-redis-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "14.0.1"

  #  values = [
  #    "${file("values.yaml")}"
  #  ]

  dynamic set {
    for_each = toset(concat([
      {
        name  = "cluster.enabled"
        value = "true"
      },
      {
        name  = "metrics.enabled"
        value = "true"
      },
      {
        name  = "service.annotations.prometheus\\.io/port"
        value = "9127"
        type  = "string"
    }], []))

    content {
      name  = set.value.name
      value = set.value.value
    }
  }
}
