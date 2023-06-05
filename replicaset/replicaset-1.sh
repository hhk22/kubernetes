kubectl apply -f replicaset.yaml

kubectl get rs -o wide
kubectl get pod -o wide
kubectl describe rs blue-replicaset
kubectl get events --sort-by=.metadata.creationTimestamp