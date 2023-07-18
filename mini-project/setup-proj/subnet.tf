
resource "aws_subnet" "test-public-subnet1" {
    depends_on = [
        aws_vpc.test-vpc
    ]

    vpc_id = aws_vpc.test-vpc.id
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = "true"
    cidr_block = "172.31.0.0/20"

    tags = {
        Name = "test-public-subnet1"
        "kubernetes.io/cluster/test-eks-cluster" = "shared"
    }
}

resource "aws_subnet" "test-public-subnet3" {
    depends_on = [
        aws_vpc.test-vpc
    ]

    vpc_id = aws_vpc.test-vpc.id
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = "true"
    cidr_block = "172.31.32.0/20"

    tags = {
        Name = "test-public-subnet3"
        "kubernetes.io/cluster/test-eks-cluster" = "shared"
    }
}