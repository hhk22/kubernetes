

-- 삭제시. 

- kubectl delete rs replicasetName  
--> 관리하고 있는 pod들도 모두 종료. 

- kubectl delete rs replicasetName --casecade=orphan
--> replicaset만 삭제. 

- kubectl get pod podName -o jsonpath="{.metadata.ownerReferences[0].name}"
--> 확인방법. 

-- 또다른 방법. 
- kubectl scale rs replicasetName --replicas 0
- kubectl delete rs replicasetName

replicaset은 replicas가 맞지 않을때만 update.  
--> template이 변경되는것은 재시작하지 않음. ( X update )


