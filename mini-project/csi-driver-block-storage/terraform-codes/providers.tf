terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket = "tt-s3-tf-state"
    key = "terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = "true"
  }
}

provider "aws" {
  region = var.aws_region
}