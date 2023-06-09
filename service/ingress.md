
```
kubectl apply -f ./ingress
kubectl get all -n snackbar
kubectl get ingress snackbar -n snackbar
kubectl get endpoints
```

요청

```
export INGRESS_IP=$(kubectl get ingress snackbar -n snackbar -o jsonpath="{.status.loadBalancer.ingress[0].ip}")

curl -H "host: order.fast-snackbar.com" --request GET $INGRESS_IP
curl -H "host: delivery.fast-snackbar.com" --request GET $INGRESS_IP
curl -H "host: payment.fast-snackbar.com" --request GET $INGRESS_IP
curl -H "host: wrong.fast-snackbar.com" --request GET $INGRESS_IP

kubectl delete ingress snackbar -n snackbar

```


single host 

```
apply -f ./ingress/ingress-single-host.yaml

curl --request GET $INGRESS_IP/order

```

