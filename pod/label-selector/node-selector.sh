
kubectl get nodes --show-labels

kubectl label node \
    gke-my-cluster-default-pool-6f2bc739-1xb4 gke-my-cluster-default-pool-6f2bc739-f4c6 \
    soil=moist

kubectl label node \
    gke-my-cluster-default-pool-6f2bc739-fqc4 \
    soild=dry


for i in {6..10};
do kubectl run tree-app-$i \
--labels="element=tree" \
--image=yoonjeong/green-app:1.0 \
--port=8081 \
--overrides=' { "spec": { "nodeSelector": {"soil":"moist"} } } ';
done


# kubectl delete pod -l element=tree