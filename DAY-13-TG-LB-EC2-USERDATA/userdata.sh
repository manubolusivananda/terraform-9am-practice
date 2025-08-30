resource "aws_instance" "web1" {
  ami           = "ami-08e5424edfe926b43" # Amazon Linux 2
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public1.id
  security_groups = [aws_security_group.ec2_sg.id]

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "WebServer1"
  }
}
