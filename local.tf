locals {
  redash = {
    name             = "redash"
    namespace        = "redash"
    chart_name       = "redash"
    chart_version    = "2.3.1"
    chart_repository = "https://getredash.github.io/contrib-helm-chart/"
  }

  redash_data = [
    {
      name = "redash1"
      values = [
        {
          name  = "redash.logLevel"
          value = "warn"
        }
      ]
      secret_values = []
    },
    {
      name = "redash2"
      values = [
        {
          name  = "redash.logLevel"
          value = "warn"
        }
      ]
      secret_values = []
    }
  ]
}
