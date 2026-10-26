resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace_v1.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_chart_version

  values = [yamlencode({
    applicationSet = { replicas = 0 }
    notifications  = { enabled = false }
    dex            = { enabled = false }
    controller = {
      resources = {
        requests = { cpu = "100m", memory = "256Mi" }
      }
    }
    server = {
      resources = {
        requests = { cpu = "50m", memory = "64Mi" }
      }
    }
    repoServer = {
      resources = {
        requests = { cpu = "50m", memory = "128Mi" }
      }
    }
    redis = {
      resources = {
        requests = { cpu = "25m", memory = "32Mi" }
      }
    }
  })]
}
