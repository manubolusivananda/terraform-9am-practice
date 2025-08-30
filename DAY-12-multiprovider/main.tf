provider "aws" {
  region = "us-east-1"

}

provider "aws" {
  region = "us-west-2"
  alias = "dev"      #alias we can use to create differernt different region we can  create resource
  profile = "prod"   # profile we can use to create different different  aws accounts inside we can create resource.
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
