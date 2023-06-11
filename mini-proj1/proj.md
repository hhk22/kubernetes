

```
gcloud container clusters get-credentials deployment --zone us-central1-c --project praxis-works-388411
gcloud container clusters get-credentials production --zone us-central1-c --project praxis-works-388411

kubectl config view

>> swtich context user
kubectl config current-context
kubectl config use-context gke_praxis-works-388411_us-central1-c_deployment
kubectl get pod

```

## Development Cluster

```
kubectl config use-context gke_praxis-works-388411_us-central1-c_deployment
kubectl create namespace order 
kubectl create namespace payment
kubectl create namespace delivery
kubectl get namepsace

kubectl create configmap port-config -n order --from-literal=ORDER_HTTP_PORT=8080
kubectl create configmap port-config -n payment --from-literal=PAYMENT_HTTP_PORT=8080
kubectl create configmap port-config -n delivery --from-literal=DELIVERY_HTTP_PORT=8080

kubectl get configmap port-config -n order
kubectl get configmap port-config -n payment
kubectl get configmap port-config -n delivery

kubectl apply -f mini-proj1/deployment_order.yaml
kubectl apply -f mini-proj1/deployment_delivery.yaml
kubectl apply -f mini-proj1/deployment_payment.yaml

kubectl get endpoints order-app -n order
kubectl get endpoints payment-app -n payment
kubectl get endpoints delivery-app -n delivery

// check 
kubectl port-forward service/order-app 8080:80 -n order
curl localhost:8080
kubectl port-forward service/delivery-app 8080:80 -n delivery
curl localhost:8080
kubectl port-forward service/payment-app 8080:80 -n payment
curl localhost:8080

// pod간의 통신 check. 
kubectl exec -it order-1.0-6b78b6578c-bhnvg -n order -- curl -sv delivery-app.delivery.svc.cluster.local
kubectl exec -it payment-1.0-6fb7d556c5-p7z77 -n payment -- curl -sv delivery-app.delivery.svc.cluster.local

// ExternalService check. 
kubectl exec -it order-1.0-6b78b6578c-bhnvg -n order -- curl -sv delivery.order.svc.cluster.local
kubectl exec -it order-1.0-6b78b6578c-bhnvg -n order -- curl -sv payment.order.svc.cluster.local

kubectl apply -f ./mini-proj1/ingress.yaml
kubectl get ingress snackbar -n order 
export INGRESS_IP=$(kubectl get ingress snackbar -n order -o jsonpath="{.status.loadBalancer.ingress[0].ip}")

curl -H "Host: order.fast-snackbar.com" --request POST $INGRESS_IP/checkout \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "Pizza": 1,
        "Burger": 2,
        "Coke": 0,
        "Juice": 0
    }'

curl -H "Host: order.fast-snackbar.com" --request GET $INGRESS_IP/menus
curl -H "Host: order.fast-snackbar.com" --request GET $INGRESS_IP/detail

kubectl apply -f mini-proj1/deployment_order2.0.yaml
service_nodeport.yaml 수정.  --> version: "1.0" -> "2.0"
kubectl apply -f mini-proj1/service_nodeport.yaml
kubectl get svc -n order -o wide

curl -H "Host: order.fast-snackbar.com" --request GET $INGRESS_IP

```


### canary deployment

```

kubectl apply -f mini-proj1/service_nodeport.yaml ( selector: app: order )
kubectl scale deployment order-1.0 -n order --replicas=3
kubectl scale deployment order-2.0 -n order --replicas=1

for i in {1..10};
do curl -sv -H "Host: order.fast-snackbar.com" --request GET $INGRESS_IP
done




```



## Production Cluster

```
kubectl config use-context gke_praxis-works-388411_us-central1-c_production
kubectl create namespace order
kubectl create namespace payment
kubectl create namespace delivery
kubectl get namepsace

kubectl create configmap port-config -n order --from-literal=ORDER_HTTP_PORT=8080
kubectl create configmap port-config -n payment --from-literal=PAYMENT_HTTP_PORT=8080
kubectl create configmap port-config -n delivery --from-literal=DELIVERY_HTTP_PORT=8080

이하 동일
...
...
...

```