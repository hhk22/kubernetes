
```
replicas: 5
maxSugre: 1
maxUnavailbe: 2
```

> kubectl get events -w

Scenario

1. 1 new-pod is created.
2. 2 old-pods are removed. and 2 new-pods are created.
3. 2 old-pods are removed, and 2 new-pods are created.
4. 1 new pod is removed, and 1 new pod is created.

