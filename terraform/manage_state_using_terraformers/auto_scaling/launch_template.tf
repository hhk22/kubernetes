resource "aws_launch_template" "tfer--eks-a4c49d63-ccfd-2446-e803-0eef1f8a51a1" {
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = "true"
      iops                  = "0"
      throughput            = "0"
      volume_size           = "20"
      volume_type           = "gp2"
    }
  }

  default_version         = "1"
  disable_api_stop        = "false"
  disable_api_termination = "false"

  iam_instance_profile {
    name = "eks-a4c49d63-ccfd-2446-e803-0eef1f8a51a1"
  }

  image_id      = "ami-049513203fe146a71"
  instance_type = "t3a.medium"

  metadata_options {
    http_put_response_hop_limit = "2"
  }

  name = "eks-a4c49d63-ccfd-2446-e803-0eef1f8a51a1"

  network_interfaces {
    device_index       = "0"
    ipv4_address_count = "0"
    ipv4_prefix_count  = "0"
    ipv6_address_count = "0"
    ipv6_prefix_count  = "0"
    network_card_index = "0"
    security_groups    = ["sg-0a8aef500bcd6e339"]
  }

  tags = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  tags_all = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  user_data = "TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSIvLyIKCi0tLy8KQ29udGVudC1UeXBlOiB0ZXh0L3gtc2hlbGxzY3JpcHQ7IGNoYXJzZXQ9InVzLWFzY2lpIgojIS9iaW4vYmFzaApzZXQgLWV4CkI2NF9DTFVTVEVSX0NBPUxTMHRMUzFDUlVkSlRpQkRSVkpVU1VaSlEwRlVSUzB0TFMwdENrMUpTVU12YWtORFFXVmhaMEYzU1VKQlowbENRVVJCVGtKbmEzRm9hMmxIT1hjd1FrRlJjMFpCUkVGV1RWSk5kMFZSV1VSV1VWRkVSWGR3Y21SWFNtd0tZMjAxYkdSSFZucE5RalJZUkZSSmVrMUVZM2RQVkVWNlRVUm5lazB4YjFoRVZFMTZUVVJqZDA1cVJYcE5SR2Q2VFRGdmQwWlVSVlJOUWtWSFFURlZSUXBCZUUxTFlUTldhVnBZU25WYVdGSnNZM3BEUTBGVFNYZEVVVmxLUzI5YVNXaDJZMDVCVVVWQ1FsRkJSR2RuUlZCQlJFTkRRVkZ2UTJkblJVSkJUVTFwQ2pOS0syVjBWblJqVFRoT1ZHTldVMmxVU2pJek9VeFNUR2x2Vm5FemFUVlNOMkppZEVsNE1rVlFOWEJMWWtzMWRsTlZaMmRUZHpjME1rRjNWbEJvWlVNS2NXcGtNVE51YTNaTGFXMXlhbkZzVmpoM01IcDZZaTlKVTBWeGVqaERUU3RCVm05dVpFOVJNVTlNTUZkWGNteGhha1JZVlhaUVZrWXdVbWRxY0doRVVncHpja2haT1hsVlJrcEtjRkpoV0dzNU1IbzNPUzh4ZUc5V05FMUtOV1UyWmpGTE1HOTRVRVprU2pWUmFsZzRaRU5xVG5KVmJWTk1WMGRYVm5SRGVFbEhDa05DWkhwVWF6aDRUMVJJT0dWeFFVdzBSVGhJZG5KeFYwaEZOWEJRUml0MmMyTlpTSGhPUm5KWldUbDNkMmROVEhCelZrSXJURmw2V1d4NFdGUlRaRVVLVWxGSGFFb3dXazU2UVVsM1RHTmhhV00xWm14R09IUnBSbkowYW5GRVNWQnpWSGQwWTBOaWVuZ3JORE5IVlhvNWFWUnBZMFpYT0ZVMEwyZGxUVGg2TVFvM2QzWlRaamhOVEVkUlp6Rm1lbTFQTDBGTlEwRjNSVUZCWVU1YVRVWmpkMFJuV1VSV1VqQlFRVkZJTDBKQlVVUkJaMHRyVFVFNFIwRXhWV1JGZDBWQ0NpOTNVVVpOUVUxQ1FXWTRkMGhSV1VSV1VqQlBRa0paUlVaRVFWZGxSM0Z2TkRGcFVqTnRMMkYzT1VOT01WZzNNbGRQZUVWTlFsVkhRVEZWWkVWUlVVOEtUVUY1UTBOdGRERlpiVlo1WW0xV01GcFlUWGRFVVZsS1MyOWFTV2gyWTA1QlVVVk1RbEZCUkdkblJVSkJTaTlyZVZWQk1FbHNhemh4WkdwbGFFaHdRUW96Y3paRWJYWkRjSFZwZDJVME9GQnRSVm93Ym5aTFMzQXpWemR3YldjeFIwd3hkVzVGUm5BMk9FTklLekV2ZVZOU1VEVm5OREl5V1U5WlozZ3ZObTlJQ2s1eFJWbElZVTVKVWpGbWRXaFlVbU5VYVVoR1pHaEhZbkphV0c1V1RqWjVOVk5IVnpabmRrWlhSRGxuUlU5MFpHOW1Obk5YWVU1QllsQlRUekkwVkc0S1MyUlFUQzlpU2s5R1JUaENaVU55YlcwdkwyUkZjekpWU1ZkWVdFYzRSRlF4YzIxalNtNXRkamhFU3pWUFZXTkxiMHhsTDFGeVNWTnVkMWg1ZFM5Mk9RcFZlbWMxZUhWbk9WcDVNRXRUTHpVMGF6aFRVR2RHU1c5b2NsSlNZVzFaVERkeFMybEdTRmROYUU1VFdUSnVSRXM0YlhadVIzVkhSRmhtZUd3emFqTnRDbnBHZFRJeE4zSTNVSFp1T1dwaWVFRkJaVFl4WjJFMk5Hb3JTMjV2Yms1UGJFWTVaRXQyTXpRMVZEbHZVRXRZVURBNWIyZElhMnhIVml0eFpYRlVNMjhLT0VkUlBRb3RMUzB0TFVWT1JDQkRSVkpVU1VaSlEwRlVSUzB0TFMwdENnPT0KQVBJX1NFUlZFUl9VUkw9aHR0cHM6Ly8xRUE4QTQ3QzVCQjI4NkE2OUY1Qjk2NDYwMzE3NEYxRi5ncjcuYXAtbm9ydGhlYXN0LTIuZWtzLmFtYXpvbmF3cy5jb20KSzhTX0NMVVNURVJfRE5TX0lQPTEwLjEwMC4wLjEwCi9ldGMvZWtzL2Jvb3RzdHJhcC5zaCB0ZXN0LWVrcy1jbHVzdGVyIC0ta3ViZWxldC1leHRyYS1hcmdzICctLW5vZGUtbGFiZWxzPWVrcy5hbWF6b25hd3MuY29tL25vZGVncm91cC1pbWFnZT1hbWktMDQ5NTEzMjAzZmUxNDZhNzEsZWtzLmFtYXpvbmF3cy5jb20vY2FwYWNpdHlUeXBlPU9OX0RFTUFORCxla3MuYW1hem9uYXdzLmNvbS9ub2RlZ3JvdXA9dGVzdC1la3Mtbm9kZWdyb3VwLHJvbGU9ZWtzLW5vZGVncm91cCAtLW1heC1wb2RzPTE3JyAtLWI2NC1jbHVzdGVyLWNhICRCNjRfQ0xVU1RFUl9DQSAtLWFwaXNlcnZlci1lbmRwb2ludCAkQVBJX1NFUlZFUl9VUkwgLS1kbnMtY2x1c3Rlci1pcCAkSzhTX0NMVVNURVJfRE5TX0lQIC0tdXNlLW1heC1wb2RzIGZhbHNlCgotLS8vLS0="
}
