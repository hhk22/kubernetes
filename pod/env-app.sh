

kubectl apply -f hello-app.yaml
kubectl get pod -o wide
kubectl exec hello-app -- env
kubectl port-forward hello-app 8080:8080
curl -v localhost:8080
kubectl delete pod --all

