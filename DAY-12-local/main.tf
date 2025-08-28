locals {
  region = "us-east-2"
  instance_type = "t2.micro"
  ami = "ami-0b016c703b95ecbe4"
}
provider "aws" {
  region = local.region
}
resource "aws_instance" "name" { 
  ami = local.ami
  instance_type = local.instance_type
}