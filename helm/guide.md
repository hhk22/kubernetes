
```
helm repo add stable https://charts.helm.sh/stable
helm repo add test-repo https://charts.bitnami.com/bitnami
helm repo list 

helm search repo nginx
helm install nginx test-repo/nginx --version 15.1.2
helm ls
helm status nginx

helm upgrade nginx test-repo/nginx --version 15.1.2
helm history nginx
helm rollback nginx 1

helm fetch test-repo/nginx --untar --version 15.1.2
helm uninstall nginx
```


## custom helm

```
helm create test
helm template
helm lint .
helm package test
helm install .
helm test nginx

helm show chart .
helm show all .

vi values.yaml // 내용 편집. 
helm upgrade nginx
helm status nginx

```



