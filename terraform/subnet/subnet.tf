resource "aws_subnet" "tfer--subnet-02784bcb3e173a4d6" {
  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "172.31.0.0/20"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                    = "public-subnet1"
    "kubernetes.io/cluster/test-eks-runner" = "shared"
  }

  tags_all = {
    Name                                    = "public-subnet1"
    "kubernetes.io/cluster/test-eks-runner" = "shared"
  }

  vpc_id = "vpc-0d005e84f2bb96266"
}

resource "aws_subnet" "tfer--subnet-09a03515a300c2fe0" {
  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "172.31.32.0/20"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                    = "public-subnet3"
    "kubernetes.io/cluster/test-eks-runner" = "shared"
  }

  tags_all = {
    Name                                    = "public-subnet3"
    "kubernetes.io/cluster/test-eks-runner" = "shared"
  }

  vpc_id = "vpc-0d005e84f2bb96266"
}
