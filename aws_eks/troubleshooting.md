aws eks --region ap-northeast-2 update-kubeconfig --name test-eks-cluster

kubectl edit configmap aws-auth -n kube-