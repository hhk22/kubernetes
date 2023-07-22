terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket = "tt-s3-tf-state"
    key = "terraform.tfstate"
    region = "ap-northeast-2"
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  exclude_names = ["ap-northeast-2a","ap-northeast-2c"]
}