provider "aws" {
  
}
#   EC2 Instance
# resource "aws_instance" "web" {
#   ami                         = "ami-0c7217cdde317cfec" # ✅ Amazon Linux 2 in us-east-1
#   instance_type               = "t2.micro"
#   associate_public_ip_address = true
#   count = 2 # same name it will create two instance 
#   tags = {
#     Name = "my-ec2"
#   }
# }

# #  EC2 Instance
# resource "aws_instance" "web" {
#   ami                         = "ami-0c7217cdde317cfec" # ✅ Amazon Linux 2 in us-east-1
#   instance_type               = "t2.micro"
#   associate_public_ip_address = true
#   count = 2

#   tags = {
#      Name = "instance-${count.index}" #same name with numbers it will create two instance
#   }
# }
#  EC2 Instance
resource "aws_instance" "web" {
  ami                         = "ami-0b016c703b95ecbe4" # ✅ Amazon Linux 2 in us-east-1
  instance_type               = "t2.micro"
  associate_public_ip_address = true
   count = length(var.ec2)
    tags = {
      Name = var.ec2[count.index]
    }
  
}

variable "ec2" {
    type = list(string)
    default = [ "dev", "test" , "prod", "preprod" ] #different names it  will create
  
}