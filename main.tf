provider "kubernetes" {
  config_path = "C:/Users/mbozzell/.kube/config"
}

# Configurazione per Helm Provider 2.x/3.x
provider "helm" {
  kubernetes = {
    config_path = "C:/Users/mbozzell/.kube/config"
  }
}

# Creazione Namespace (Versione V1 per evitare Warning)
resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "argocd"
  }
}

# Installazione ArgoCD
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argocd"
  
  wait = true

  # Questo assicura che il namespace esista prima di iniziare
  depends_on = [kubernetes_namespace_v1.argocd]
}
