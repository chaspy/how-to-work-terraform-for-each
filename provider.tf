provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      region  = "ap-northeast-1"
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}
