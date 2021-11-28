provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-terraform"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-terraform"
  }
}
