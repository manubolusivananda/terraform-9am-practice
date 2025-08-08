resource "aws_instance" "name" {
    ami = "ami-0d1891272a8f97fb4"
    instance_type = "t2.micro"
    tags = {
        Name = "developer"
    }
  
}
