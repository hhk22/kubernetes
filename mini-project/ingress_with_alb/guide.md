
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