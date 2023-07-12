

-- prerequisites : ../ingress_with_alb

- kubectl create namespace test-service-nlb
- yaml ( test-deployment-nginx.yaml )
    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: nlb-sample-app
    namespace: test-service-nlb
    spec:
    replicas: 3
    selector:
        matchLabels:
        app: nginx
    template:
        metadata:
        labels:
            app: nginx
        spec:
        containers:
            - name: nginx
            image: public.ecr.aws/nginx/nginx:1.21
            ports:
                - name: tcp
                containerPort: 80
    ```
    > kubectl apply -f test-deployment-nginx.yaml  
    > kubectl get pods -n test-service-nlb

- yaml  (test-service.yaml )
  ```
    apiVersion: v1
    kind: Service
    metadata:
    name: nlb-sample-service
    namespace: test-service-nlb
    annotations:
        service.beta.kubernetes.io/aws-load-balancer-type: external
        service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: ip
        service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing
        service.beta.kubernetes.io/subnets: <Public Subnet1 ID>, <Public Subnet2 ID>
    spec:
    ports:
        - port: 80
        targetPort: 80
        protocol: TCP
    type: LoadBalancer
    selector:
        app: nginx
  ```
  > kubectl apply -f test-service.yaml 
  > kubectl get svc -n test-service-nlb

- 
