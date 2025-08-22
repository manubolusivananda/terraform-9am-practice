provider "aws" {
  
}
resource "aws_instance" "name" {
    ami = "ami-0b016c703b95ecbe4"
    instance_type = "t2.micro"
    tags = {
      Name = "instance"
    }
  
}
resource "aws_s3_bucket" "name" {
   bucket = "sivanandalkmodfnmo"

  
}
