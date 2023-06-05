
kubectl apply -f ./replicaset.yaml

// --> template 수정

kubectl scale rs myapp --replicas=3
kubectl get pod --show-labels

