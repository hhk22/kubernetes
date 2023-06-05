kubectl apply -f ./

kubectl get pod --show-labels
kubectl get pod -L group

kubectl label pod hello-app-1 version=v1
kubectl label pod rose-app-1 concept=flower element=rose position=bottom version=v1
kubectl label pod sky-app-1 concept=earth element=sky position=top version=v1
kubectl label pod tree-app-1 concept=earth element=tree position=bottom version=v1
kubectl label pod tree-app-2 concept=earth element=tree position=bottom version=v1

kubectl get pod -L group,concept,position,version

kubectl get pod --selector group=nature
kubectl get pod --selector 'concept in (earth,flower)'
kubectl get pod --selector 'concept notin (earth,flower)'
kubectl get pod --selector '!concept'

kubectl get pod --selector group=nature,position=bottom

kubectl label pod tree-app-1 concept=mountain --overwrite  // 이미 있는 key는 overwrite를 추가해야함.
kubectl label pod hello-app-1 version-  // delete label key

kubectl delete pod -l group