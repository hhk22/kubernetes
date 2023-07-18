resource "aws_route_table" "test_route_table_pubsub1" {
    
    depends_on = [
        aws_vpc.test-vpc,
        aws_internet_gateway.test_igw
    ]

    vpc_id = aws_vpc.test-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test_igw.id
    }

    tags = {
        Name = "test_route_table_pubsub1"
    }

}

resource "aws_route_table" "test_route_table_pubsub3" {
    
    depends_on = [
        aws_vpc.test-vpc,
        aws_internet_gateway.test_igw
    ]

    vpc_id = aws_vpc.test-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test_igw.id
    }

    tags = {
        Name = "test_route_table_pubsub3"
    }

}

resource "aws_route_table" "test_route_table_pubsub-pod1" {
    
    depends_on = [
        aws_vpc.test-vpc,
        aws_internet_gateway.test_igw
    ]

    vpc_id = aws_vpc.test-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test_igw.id
    }

    tags = {
        Name = "test_route_table_pubsub-pod1"
    }

}

resource "aws_route_table" "test_route_table_pubsub-pod3" {
    
    depends_on = [
        aws_vpc.test-vpc,
        aws_internet_gateway.test_igw
    ]

    vpc_id = aws_vpc.test-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test_igw.id
    }

    tags = {
        Name = "test_route_table_pubsub-pod3"
    }

}