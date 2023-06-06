
```
... 모두 기존과 동일

... 
name: order
kind: Service
...
spec:
    type: LoadBalancer
...


```

> kubectl apply -f loadbalancer.yaml  
> kubectl get svc -l project=snackbar -n snackbar  
> export ORDER=34.134.118.88  
> curl http://$ORDER  
> curl http://$ORDER/menus



