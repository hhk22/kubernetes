
resource "aws_internet_gateway" "test_igw" {
    depends_on = [
        aws_vpc.test-vpc
    ]

    vpc_id = aws_vpc.test-vpc.id

    tags = {
        Name = "test_igw"
    }
}