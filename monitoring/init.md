
## kubernetes metric-server

```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

```

### 실제 metric-server API 로 호출

```
# nodes
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes" | jq '.'
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes/worker-0" | jq '.'

# pods
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/namespaces/kube-system/pods" | jq '.'
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/namespaces/kube-system/pods/<pod-name>" | jq '.'

```

## HPA with metric-server

```
kubectl apply -f https://k8s.io/examples/application/php-apache.yaml
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10

kubectl run -i --tty load-generator-0 --rm --image=busybox:1.28 --restart=Never -- //bin//sh -c "while sleep 0.05; do echo "ok"; done"

```


## ProMetheus

```
git clone https://github.com/prometheus-operator/kube-prometheus.git
cd kube-prometheus
kubectl create -f manifests/setup/
kubectl create -f manifests

## Load Balancer Type 추가 
vi manifests/grafana-service.yaml  # type: LoadBalancer 
vi manifests/alertmanager-service.yaml  # type: LoadBalancer 
vi manifests/prometheus-service.yaml  # type: LoadBalancer 
kubectl apply -f manifests/grafana-service.yaml
kubectl apply -f manifests/alertmanager-service.yaml
kubectl apply -f manifests/prometheus-service.yaml

```

## Slack 과 연동. 

1. 수신 웹후크 플러그인 설치 -> 채널 선택 -> 웹 후크 URL 복사 