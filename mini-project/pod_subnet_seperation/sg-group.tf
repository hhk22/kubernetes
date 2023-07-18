
resource "aws_security_group" "test-sg-eks-cluster" {
    depends_on = [
        aws_vpc.test-vpc
    ]

    name = "test-sg-eks-cluster"
    vpc_id = aws_vpc.test-vpc.id

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "test-sg-eks-cluster"
    }

}