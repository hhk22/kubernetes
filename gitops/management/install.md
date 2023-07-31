
## ArgoCD

```

kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

// 패스워드 확인방법  
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

```

## ArgoRollout

```

kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

// plugins
curl -LO https://github.com/argoproj/argo-rollouts/releases/download/v1.1.0/kubectl-argo-rollouts-windows-amd64

sudo mv ./kubectl-argo-rollouts-windows-amd64 /usr/local/bin/kubectl-argo-rollouts

kubectl argo rollouts dashboard &

```