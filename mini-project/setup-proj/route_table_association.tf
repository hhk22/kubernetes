
resource "aws_route_table_association" "test_route_association_pub_sub1" {
    route_table_id = aws_route_table.test_route_table_pubsub1.id
    subnet_id = aws_subnet.test-public-subnet1.id
}

resource "aws_route_table_association" "test_route_association_pub_sub3" {
    route_table_id = aws_route_table.test_route_table_pubsub3.id
    subnet_id = aws_subnet.test-public-subnet3.id
}