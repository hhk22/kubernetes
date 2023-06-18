
```
kubectl rollout history deployment/my-app
kubectl rollout history deployment/my-app --revision=2

kubectl rollout undo deployment/my-app
kubectl rollout undo deployment/my-app --to-revision=1

kubectl annotate deployment/my-app kubernetes.io/change.cause="rollback to 1.0"
```

```
apiVersion: apps/v1
kind: Deployment
metadata:
    name: ...
    labels:
        ...
    annotations:
        kubernetes.io/change.cause: "..."
    ...
...
```