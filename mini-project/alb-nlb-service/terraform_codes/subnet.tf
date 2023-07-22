
resource "aws_subnet" "test-public-subnet1" {

  depends_on = [
    aws_vpc.test-vpc
  ]

  cidr_block                                     = "172.31.0.0/20"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                     = "test-public-subnet1"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
  }

  vpc_id = aws_vpc.test-vpc.id
  availability_zone = "ap-northeast-2a"
}

resource "aws_subnet" "test-public-subnet3" {

  depends_on = [
    aws_vpc.test-vpc
  ]

  cidr_block                                     = "172.31.16.0/20"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                     = "test-public-subnet3"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
  }

  vpc_id = aws_vpc.test-vpc.id
  availability_zone = "ap-northeast-2c"
}


resource "aws_subnet" "test-private-subnet1" {

  depends_on = [
    aws_vpc.test-vpc
  ]

  cidr_block                                     = "172.31.32.0/20"
  map_public_ip_on_launch                        = "false"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                     = "test-private-subnet1"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
  }

  vpc_id = aws_vpc.test-vpc.id
  availability_zone = "ap-northeast-2a"
}

resource "aws_subnet" "test-private-subnet3" {

  depends_on = [
    aws_vpc.test-vpc
  ]

  cidr_block                                     = "172.31.48.0/20"
  map_public_ip_on_launch                        = "false"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                     = "test-private-subnet3"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
  }

  vpc_id = aws_vpc.test-vpc.id
  availability_zone = "ap-northeast-2c"
}