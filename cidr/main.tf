provider "aws" {
  region = "us_east_2" # ✅ using us-east-1
}
# 6. Security Group (multiple ports)
resource "aws_security_group" "multi_port" {
  name        = "sgmultipleports"
  description = "Allow multiple ports"
  vpc_id      = aws_vpc.main.id

  ingress = [
    for port in [22, 80, 443, 8080, 9000, 3000, 8082, 8081] : {
      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "multi-port-sg"
  }
}
# 7. EC2 Instance
resource "aws_instance" "web" {
  ami                         = "ami-0b016c703b95ecbe4" # ✅ Amazon Linux 2 in us-east-1
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.multi_port.id]
  associate_public_ip_address = true

  tags = {
    Name = "my-ec2"
  }
} 