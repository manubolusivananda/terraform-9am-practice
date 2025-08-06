# terraform {
#   required_version = "~> 1.12.2 "
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "6.5.0"
#     }
#   }
# }

provider "aws" {
  region = "us-west-1"
  # Configuration options
}