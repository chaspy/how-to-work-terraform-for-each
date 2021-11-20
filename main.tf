resource "kubernetes_namespace" "redash" {
  metadata {
    name = local.redash.namespace
  }
}

resource "random_password" "redash_cookie_secret" {
  count = length(local.redash_data)

  length  = 32
  special = false
}

resource "random_password" "redash_secret_key" {
  count = length(local.redash_data)

  length  = 32
  special = false
}

resource "helm_release" "redash" {
  count = length(local.redash_data)

  name       = local.redash_data[count.index].name
  namespace  = local.redash.namespace
  repository = local.redash.chart_repository
  chart      = local.redash.chart_name
  version    = local.redash.chart_version

  values = [file("values.redash.yml")]

  dynamic "set" {
    for_each = local.redash_data[count.index].values
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set_sensitive" {

    for_each = toset(concat([
      {
        name  = "redash.secretKey"
        value = base64encode(random_password.redash_secret_key[count.index].result)
      },
      {
        name  = "redash.cookieSecret"
        value = base64encode(random_password.redash_cookie_secret[count.index].result)
      }
    ], local.redash_data[count.index].secret_values))

    content {
      name  = set_sensitive.value.name
      value = set_sensitive.value.value
    }
  }
  timeout = 600
  depends_on = [
    kubernetes_namespace.redash,
  ]
}
