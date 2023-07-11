variable "aws_region" {
  default = "ap-northeast-2"
}

variable "cluster-name" {
  default = "test-eks-cluster"
  type    = string
}

data "terraform_remote_state" "local" {
  backend = "local"
}
