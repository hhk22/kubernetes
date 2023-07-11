resource "aws_route_table" "tfer--rtb-01131bbb0737495df" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-07b8beba6e51bc121"
  }

  tags = {
    Name = "public-subnet1-routing"
  }

  tags_all = {
    Name = "public-subnet1-routing"
  }

  vpc_id = "vpc-0d005e84f2bb96266"
}

resource "aws_route_table" "tfer--rtb-0876e73d764fd0a28" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-07b8beba6e51bc121"
  }

  tags = {
    Name = "public-subnet3-routing"
  }

  tags_all = {
    Name = "public-subnet3-routing"
  }

  vpc_id = "vpc-0d005e84f2bb96266"
}

resource "aws_route_table" "tfer--rtb-0f37da50152e19728" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-07b8beba6e51bc121"
  }

  vpc_id = "vpc-0d005e84f2bb96266"
}
