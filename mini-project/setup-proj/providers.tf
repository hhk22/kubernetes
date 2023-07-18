terraform {

    backend "s3" {
        bucket = "tt-s3-tf-state"
        key = "terraform.tfstate"
        region = "ap-northeast-2"
    }
}

provider "aws" {
    region = "ap-northeast-2"
}
