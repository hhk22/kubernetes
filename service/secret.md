
```

kubectl create secret generic tls-config --from-file=service/secrets/https.cert --from-file=service/secrets/https.key
kubectl apply -f service/secret.yaml
curl -sv https://127.0.0.1:8443/myapp
>> unknown CA

curl --cacert service/secrets/https.cert -sv https://127.0.0.1:8443/myapp

```