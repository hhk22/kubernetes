- What - Pod
- How many - ReplicaSet
- Where - Node, Namespace
- How - Deployment
- Traffic LoadBalancing - Service, Endpointg

```
// 리소스 목록 조회. 
kubectl api-resources

// 설명
ex) kubectl explain deployment
ex) kubectl explain deployment.metadata

// mini-project
kubectl get ndoes

kubectl apply -f deployment.yaml
kubectl scale -f deployment.yaml --replicas=3

kubectl diff -f deployment.yaml
kubectl edit deployment/nginx-deployment:

kubectl port-forward pod/nginx-deployment-<id> 8080:80

kubectl attach deployment/nginx-deployment -c nginx
kubectl logs deployment/nginx-deployment -c nginx -f


```

