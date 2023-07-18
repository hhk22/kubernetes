resource "aws_vpc" "test-vpc" {
  cidr_block                       = "172.31.0.0/16"
  enable_dns_hostnames             = "true"
  enable_dns_support               = "true"
  instance_tenancy                 = "default"

  tags = {
    Name = "test-vpc"
  }

  tags_all = {
    Name = "test-vpc"
  }
}