provider "aws" {
  
}
resource "aws_instance" "count" {
  ami = "ami-0b016c703b95ecbe4"
  instance_type = "t2.micro"
  for_each = toset(var.ec2)
  #count = length(var.ec2)
  tags = {
   Name = each.value
  }
}
variable "ec2" {
  type = list(string)
  default = [ "test", "dev" ] # foreach  used to delete which one you want to delete that one only delete
} 