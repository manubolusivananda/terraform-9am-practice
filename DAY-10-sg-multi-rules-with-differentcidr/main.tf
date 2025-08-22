provider "aws" {
  
}
variable "allowed_ports" {
  type = map(string)
  default = {
    22    = "203.0.113.0/24"    # SSH (Restrict to office IP)
    80    = "0.0.0.0/0"         # HTTP (Public)
    443   = "0.0.0.0/0"         # HTTPS (Public)
    8080  = "10.0.0.0/16"       # Internal App (Restrict to VPC)
    9000  = "192.168.1.0/24"    # SonarQube/Jenkins (Restrict to VPN)
    3389  = "10.0.1.0/24"
    3306  = "192.168.1.2/32"
  }
}

resource "aws_security_group" "map_string" {
  name        = "map-string"
  description = "Allow restricted inbound traffic"

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description = "Allow access to port ${ingress.key}"
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
     
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project-veera"
  }
}
# 7. EC2 Instance
resource "aws_instance" "web" {
  ami                         = "ami-0b016c703b95ecbe4" # ✅ Amazon Linux 2 in us-east-1
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.map_string.id]
  associate_public_ip_address = true

  tags = {
    Name = "siva-ec2"
  }
} 