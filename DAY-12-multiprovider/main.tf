provider "aws" {
  region = "us-east-1"

}

provider "aws" {
  region = "us-west-2"
  alias = "dev"
  profile = "prod"
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    provider = aws.dev
  
}

resource "aws_s3_bucket" "name" {
    bucket = "tdcsgddhsvdsh"
  
}
provider "aws" {
  region = "us-east-2"
  
}


  
#aws configure --profile prod  different account it will create