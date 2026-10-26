# tp-gitops-infra

## Ce que c'est

Le code Terraform qui installe l'agent de déploiement continu ArgoCD dans le cluster AKS du TP. Il ne contient rien d'autre.

## Ce que ça fait

Il crée le namespace `argocd` et y installe le chart Helm `argo-cd` en version 10.11.6.

Les composants optionnels sont coupés pour tenir sur un seul node de 2 vCPU. Le contrôleur ApplicationSet est mis à zéro réplica, les notifications et Dex sont désactivés. Chaque composant actif a des `requests` modestes.

Les applications et les composants tiers ne sont pas déployés ici. Ils sont décrits dans le dépôt `tp-gitops-manifests` et ArgoCD les synchronise seul.

## Comment ça marche

Le state est stocké dans un compte de stockage Azure, avec une authentification Azure AD et sans clé d'accès. Les providers `helm` et `kubernetes` lisent le kubeconfig local, qui s'appuie sur Azure CLI.

```bash
terraform init
terraform plan -out=argocd.tfplan
terraform apply argocd.tfplan
```

Une fois ArgoCD en place, l'amorçage se fait en appliquant une seule fois `bootstrap/root-app.yaml` du dépôt de manifestes. Tout le reste passe ensuite par Git.

## Dépendances

- Terraform 1.9 ou plus récent
- Provider `hashicorp/helm` en 3.x et provider `hashicorp/kubernetes` en 3.x
- Un cluster AKS accessible par `kubectl`
- Un accès au compte de stockage du state
