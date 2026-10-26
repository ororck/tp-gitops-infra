output "argocd_namespace" {
  description = "Namespace where the CD agent runs"
  value       = kubernetes_namespace_v1.argocd.metadata[0].name
}

output "argocd_chart_version" {
  description = "Deployed version of the argo-cd chart"
  value       = helm_release.argocd.version
}
