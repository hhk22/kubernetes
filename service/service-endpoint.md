
```
kubectl create namespace snackbar
```

```
#service.yaml

apiVersion: v1
kind: Service
metadata:
    name: order
    namespace: snackbar
    labels:
        service: order
        project: snackbar
spec:
    type: ClusterIP
    selector:
        service: order
        project: snackbar
    ports:
    - port: 80
      targetPort: 8080
```

```
# payment.yaml

apiVersion: v1
kind: Service
metadata:
    name: payment
    namespace: snackbar
    labels:
        service: payment
        project: snackbar
spec:
    type: ClusterIP
    selector:
        service: payment
        project: snackbar
    ports:
    - port: 80
      targetPort: 8080
```

```
# deploy-order.yaml

apiVersion: apps/v1
kind: Deployment
metadata: 
    name: order
    namespace: snackbar
    labels:
        service: order
        project: snackbar
spec:
    replicas: 2
    selector:
        matchLabels:
            service: order
            project: snackbar
    template:
        metadata:
            labels:
                service: order
                project: snackbar
        spec:
            containers:
                - name: order
                  image: yoonjeong/order:1.0
                  ports:
                  - containerPort: 8080
                  resources:
                    limits:
                        memory: "64Mi"
                        cpu: "50m"
```


```
# deploy-payment.yaml

apiVersion: apps/v1
kind: Deployment
metadata: 
    name: payment
    namespace: snackbar
    labels:
        service: payment
        project: snackbar
spec:
    replicas: 2
    selector:
        matchLabels:
            service: payment
            project: snackbar
    template:
        metadata:
            labels:
                service: payment
                project: snackbar
        spec:
            containers:
                - name: payment
                  image: yoonjeong/payment:1.0
                  ports:
                  - containerPort: 8080
                  resources:
                    limits:
                        memory: "64Mi"
                        cpu: "50m"
```

> kubectl apply -f service.yaml  
> kubectl get all -n snackbar

> kubectl get svc order -o wide -n snackbar  
> kubectl get svc payment -o wide -n snackbar

> kubectl get endpoints -n snackbar  
> kubectl get svc order -o "{.spec.clusterIP}" -n snackbar

> kubectl clusterIP >>> fail
> kubectl port-forward service order 8080:80 -n snackbar  
> curl localhost:8080



## clusterIP 서비스로 pod를 외부로 노출하는 방법. 

```
kubectl exec -it order-55468df7b9-bq2nw -c order -n snackbar -- sh
curl $PAYMENT_SERVICE_HOST:$PAYMENT_SERVICE_PORT

for i in `seq 1 10`;
do curl -s $PAYMENT_SERVICE_HOST:$PAYMENT_SERVICE_PORT;
done

kubectl exec -it order-55468df7b9-bq2nw -n snackbar -- curl -s payment:80
kubectl exec -it order-55468df7b9-bq2nw -n snackbar -- cat /etc/hosts

kubectl get all -n kube-system | grep kube-dns
cat /etc/resolve.conf

```

새로운 namespace의 pod 생성. 

```
kubectl create namespace fancy-snackbar
```

```
# fancy-snackbar.yaml

apiVersion: v1
kind: Service
metadata:
    name: delivery
    namespace: fancy-sanckbar
    labels:
        service: delivery
        projecT: snackbar
spec:
    type: ClusterIP
    selector:
        service: delivery
        project: snackbar
    ports:
    - port: 80
      targetPort: 8080


---

apiVersion: apps/v1
kind: Deployment
metadata:
    name: delivery
    namespace: fancy-snackbar
    labels:
        service: delivery
        project: snackbar
spec:
    replicas: 2
    selector:
        matchLabels:
            service: delivery
            project: snackbar
    template:
        metadata:
            service: delivery
            project: snackbar
        spec:
            containers:
            - name: delivery
              image: yoonjeong/my-app:2.0
              ports:
              - containerPort: 8080
              resources:
                limits:
                  memory: "64Mi"
                  cpu: "50m"
```

```
kubectl create namespace fancy-snackbar
kubectl apply -f fancy-snackbar.yaml

kubectl get endpoints -l project=snackbar -n fancy-snackbar

kubectl get svc -n fancy-snackbar
kubectl exec -it order-55468df7b9-bq2nw -n snackbar -- curl delivery.fancy-snackbar

kubectl delete all -l project=snackbar --all-namespaces
```

