
## ALB controller 를 통한 EKS cluster를 구성 ( 외부에서 eks cluster 접근 불가. )


- Bastion 서버에 대한 ec2
    - ./ec2_instance.tf
    - iam_instance_profile
    ```
    resource "aws_iam_instance_profile" "test-ec2-instance-profile" {
        name = "test-ec2-instance-profile"
        path = "/"
        role = "test-iam-role-ec2-instance-bastion"
    }
    ```
    - iam_roles
    ```
    resource "aws_iam_role" "test-iam-role-ec2-instance-bastion" {
        assume_role_policy = <<POLICY
        {
            "Statement": [
                {
                    "Action": "sts:AssumeRole",
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ec2.amazonaws.com"
                    }
                }
            ],
            "Version": "2012-10-17"
        }
        POLICY
        name = "test-iam-role-ec2-instance-bastion"
        description          = "Iam role for bastion ec2 instance."
        max_session_duration = "3600"
        path                 = "/"

        tags = {
            Name        = "test-iam-role-ec2-instance-bastion"
        }
        tags_all = {
            Name        = "test-iam-role-ec2-instance-bastion"
        }
    }
    ```
    - security grroup
    ```
    resourrce "aws_security_group" "test-sg-bastion" {
        name = "test-sg-bastion"
        vpc_id = aws_vpc.test_vpc.id

        ingress {
            cidr_blocks = ["0.0.0.0/0"]
            description = "ingress security_group_rule for bastion"
            from_port   = "22"
            protocol    = "tcp"
            self        = "false"
            to_port     = "22"
        }

        egress {
            cidr_blocks = ["0.0.0.0/0"]
            description = "egress security_group_rule for bastion"
            from_port   = "0"
            protocol    = "tcp"
            self        = "false"
            to_port     = "65535"
        }

        tags = {
            Name = "test-sg-bastion"
        }
    }
    ```
    - kube_config 설정
    ```
    aws eks update-kubeconfig --region ap-northeast-2 --name test-eks-cluster
    kubectl get nod # eks-cluster에 접속가능. 
    ```

- test용 pod 생성
    - pod가 사용할 namespace 생성.
        >  kubectl create namespace test-igress-alb
    - test-deployment-game.yaml
        ```
        ---
        apiVersion: apps/v1
        kind: Deployment
        metadata:
        name: deployment-2048
        namespace: test-ingress-alb
        spec:
        selector:
            matchLabels:
            app.kubernetes.io/name: app-2048
        replicas: 5
        template:
            metadata:
            labels:
                app.kubernetes.io/name: app-2048
            spec:
            containers:
            - image: alexwhen/docker-2048
                imagePullPolicy: Always
                name: app-2048
                ports:
                - containerPort: 80
        ---
        apiVersion: v1
        kind: Service
        metadata:
        name: service-2048
        namespace: test-ingress-alb
        spec:
        ports:
            - port: 80
            targetPort: 80
            protocol: TCP
        type: NodePort
        selector:
            app.kubernetes.io/name: app-2048
        ```
    - 배포
        > kubectl create -f test-deployment-game.yaml
- eks ctl 설치
- reference : https://catalog.us-east-1.prod.workshops.aws/workshops/9c0aa9ab-90a9-44a6-abe1-8dff360ae428/ko-KR/60-ingress-controller/100-launch-alb
- aws alb
    - alb용 iam policy 생성
        ```
        resource "aws_iam_policy" "test-alb-iam-policy" {
            name = "test-alb-iam-policy"
            path = "/"

            policy = jsonencode (
                <./alb_ingress.json>
            )
        }
        ```
- eks 용 계정 생성
    ```
    eksctl utils associate-iam-oidc-provider --region=ap-northeast-2 --cluster=test-eks-cluster --approve

    eksctl create iamserviceaccount \
    --cluster=test-eks-cluster \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --atach-policy-arn=arn:aws:iam::<account_id>:policy/test-alb-iam-policy \
    --override-existing-serviceaccounts \
    --approve
    ```

- aws alb controller 
    - cert manager
        > kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.5.4/cert-manager.yaml 
        > kubectl get pods --namespace cert-manager
    - alb controller
       ```
       wget https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.4/v2_4_4_full.yaml
       spec.containers.args.cluster-name 을 자신의 cluster-name으로 수정. 

       kubectl apply -f alb-controller.yaml
       kubectl get pods -n kube-system

       ``` 

- ingress
    - yaml (ingress.yaml)
        ```
        apiVersion: networking.k8s.io/v1beta1
        kind: Ingress
        metadata:
        name: ingress-2048
        namespace: test-ingress-alb
        annotations:
            kubernetes.io/ingress.class: alb
            alb.ingress.kubernetes.io/scheme: internet-facing
            alb.ingress.kubernetes.io/target-type: ip
            alb.ingress.kubernetes.io/subnets: <Public Subnet1 ID>, <Public Subnet2 ID>
        spec:
        rules:
            - http:
                paths:
                - path: /*
                    backend:
                    serviceName: service-2048
                    servicePort: 80
        ```

        kubectl create -f ingress.yaml 
