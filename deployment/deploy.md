
- 기본적인 배포

```
kubectl apply -f deployment.yaml
kubectl describe deployment
kubectl rollout status deployment my-app
```

- replicas 조정

```
kubectl scale deployment my-app --replicas=3
```

- template 변경. 
```
// template image 변경
kubectl set image deployment my-app my-app=yoonjeong/my-app:2.0

// template label 추가
yaml 파일 변경 후, 
kubectl apply -f deployment.yaml
```