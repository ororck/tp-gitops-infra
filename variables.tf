variable "kubeconfig_path" {
  description = "Path to the kubeconfig used to reach the cluster"
  type        = string
  default     = "~/.kube/config"
}

variable "argocd_chart_version" {
  description = "Pinned version of the argo-cd Helm chart"
  type        = string
  default     = "10.11.6"
}
