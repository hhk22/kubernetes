resource "aws_vpc" "tfer--vpc-0d005e84f2bb96266" {
  assign_generated_ipv6_cidr_block     = "false"
  cidr_block                           = "172.31.0.0/16"
  # enable_classiclink                   = "false"
  # enable_classiclink_dns_support       = "false"
  enable_dns_hostnames                 = "true"
  enable_dns_support                   = "true"
  enable_network_address_usage_metrics = "false"
  instance_tenancy                     = "default"
  ipv6_netmask_length                  = "0"
}
