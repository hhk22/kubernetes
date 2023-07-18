
### 기존의 worker node 와 pod 의 ip 대역을 같이 공유하고 있었는데, 이것을 나눠서 사용하도록 하는 구조

> kubectl get pods -o wide  
> 모든 pod들이 172.31 대역대를 잡고 있는것을 알 수 있음. 

1. VPC에 새로운 CIDR 추가. (100.64.0.0/16)
2. pod security group 생성. 

```

ref:  https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/cni-custom-network.html

#subnet.tf

...

아래 내용 추가. 

resource "aws_subnet" "public-subnet-eks-pods-a" {

  depends_on = [
    aws_vpc.test-vpc
  ]

  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "100.64.0.0/19"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                     = "public-subnet-eks-pods-a"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
  }

  tags_all = {
    Name                                     = "public-subnet-eks-pods-a"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
  }

  vpc_id = aws_vpc.test-vpc.id
  availability_zone = "ap-northeast-2a"
}


-- public-subnet-eks-pods-c 에 대해서도 동일. (CIDR : 100.64.32.0/19)
-- availability_zone = "ap-northeast-2c"


# route_tables.tf

... 

resource "aws_route_table" "test-rt-eks-pods-a" {
    route {
        cidr_block="0.0.0.0/0"
        gateway_id="..."
    }

    tags {
        Name="test-rt-eks-pods-a"
    }

    tags_all {
        Name="test-rt-eks-pods-a"
    }

    vpc_id= "..."
}

-- test-rt-eks-pods-c 에 대해서도 동일. 



# route_table_association.tf

...

resource "aws_route_table_association" "test-rta-eks-pods-a" {
    route_table_id = aws_route_table.test-rt-eks-pods-a.id
    subnet = aws_subnet.public-subnet-eks-pods-a.id
}

resource "aws_route_table_association" "test-rta-eks-pods-a" {
    route_table_id = aws_route_table.test-rt-eks-pods-c.id
    subnet = aws_subnet.public-subnet-eks-pods-c.id
}


# security_group.tf

...

resource "aws_security_group" "test-sg-eks-pods" {
    name = "test-sg-eks-pods"
    description = ... 
    vpc_id = ...

    tags = {
        Name = "test-sg-eks-pods"
    }
}

resource "aws_security_group_rule" "test-sg-eks-pods-ingress" {

  security_group_id = aws_security_group.test-sg-eks-pods-egress.id
  type              = "ingress"
  description       = "ingress security_group_rule for test-eks-pods"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "test-sg-eks-pods-egress" {

  security_group_id = aws_security_group.test-sg-eks-pods-egress.id
  type              = "egress"
  description       = "egress security_group_rule for test-eks-pods"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


```


## ENI config 설정. 

```

#eniconfig.yaml 

--- 
apiVersion: crd.k8s.amazonaws.com/v1alpha1
kind: ENIConfig
metadata:
 name: ap-northeast-2a
spec:
  securityGroups: 
    - <Security Group ID>
  subnet: <Subnet ID 1>
---
apiVersion: crd.k8s.amazonaws.com/v1alpha1
kind: ENIConfig
metadata:
 name: ap-northeast-2c
spec:
  securityGroups: 
    - <Security Group ID>
  subnet: <Subnet ID 2>

```

```


kubectl get ENIconfig
kubectl create -f .

kubectl set env daemonset aws-node -n kube-system AWS_VPC_K8s_CNI_CUSTOM_NETWORK_CFG=true
kubectl set env daemonset aws-node -n kube-system ENI_CONFIG_LABEL_DEF=failure-domain.beta.kubernetes.io/zone

kubectl rollout restart ds fluentd-elasticsearch
>> second cidr 적용 안됨. 

```

## 변경된 정보 node group 에 반영. 

- desired_state 1 --> 2

```
kubectl scale deploy <deployment_name>  --repliaces=2
kubectl get pods -o wide

- desired_state 2 --> 1

```