
-- yaml

```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  app: myapp-replicaset
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp-replicaset
  template:
    metadata:
      labels: 
        app: myapp-replicaset
    spec:
      containers:
      - name: my-app
        image: yoonjeong/my-app:2.0-unhealthy
        ports:
        - containerPort: 8080
        resources:
          limits:
            memory: "64Mi"
            cpu: "50m"
```

> kubectl apply -f yaml_file

> kubectl port-forward rs/myapp-replicaset 8080:8080

```
# trigger error
for i in {0..5};
do curl -vs localhost:8080;
done;
```

> kubectl set image rs/myapp-replicaset my-app=yoonjeong/my-app:1.0  
> kubectl get rs/myapp-replicaset -o wide

```
kubectl label pod <pod_name> app=to-be-fixed --overwrite
kubectl label pod <pod_name> app=to-be-fixed --overwrite
kubectl label pod <pod_name> app=to-be-fixed --overwrite


// 변경된 이미지 확인. 
kubectl get rs myapp-replicaset -o wide
kubectl get pod -o wide

```

