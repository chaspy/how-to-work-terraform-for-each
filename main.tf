terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

locals {
  images = [
    { name = "foo", image = "alpine" },
    { name = "bar", image = "debian" },
  ]
}

resource "docker_container" "this" {
  # for_each = local.images ここにmapのlistを渡したいがエラーになる
  for_each = { for i in local.images : i.name => i } # こう書くのが正しい
  name     = each.value.name
  image    = each.value.image
}
