resource "aws_vpc" "name" {
  cidr_block = var.cidr_block_vpc
  tags = {
    Name = "vpc"
  }
}
resource "aws_subnet" "pub_sub" {
  vpc_id = aws_vpc.name.id
  cidr_block = var.cidr_block_pub_sub
  availability_zone = "us-west-1a"
}
resource "aws_subnet" "pv_sub" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.cidr_block_pv_sub
    availability_zone = "us-west-1c"
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.name.id
  
}
resource "aws_eip" "el" {
    domain = "vpc"
  
}
resource "aws_nat_gateway" "ngw" {
    subnet_id = aws_subnet.pub_sub.id
    allocation_id = aws_eip.el.id

}
resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "prt"
    }
    route {
        gateway_id = aws_internet_gateway.igw.id
        cidr_block = "0.0.0.0/0"
    }
}
resource "aws_route_table_association" "pub_ass" {
    subnet_id = aws_subnet.pub_sub.id
    route_table_id = aws_route_table.pub_rt.id

}
resource "aws_route_table" "pvrt" {
    vpc_id = aws_vpc.name.id
    route {
        nat_gateway_id = aws_nat_gateway.ngw.id
        cidr_block =  "0.0.0.0/0"

    }

}
resource "aws_route_table_association" "pvrt_ass" {
  subnet_id = aws_subnet.pv_sub.id
  route_table_id = aws_route_table.pvrt.id
}
resource "aws_security_group" "sgr" {
  name = "sgr"
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "sg"
  }
  ingress {
    description = "tls from vpc"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "tls from vpc"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "tls from vpc"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"#all traffic
    cidr_blocks =  ["0.0.0.0/0"]
  }
}    
resource "aws_instance" "pu_server" {
    ami = var.ami_id1
    instance_type = var.type1
    subnet_id = aws_subnet.pub_sub.id
    vpc_security_group_ids = [aws_security_group.sgr.id]
    associate_public_ip_address = true                   
}
  
resource "aws_instance" "pv_server" {
  ami = var.ami_id2
  instance_type = var.type2
  vpc_security_group_ids = [aws_security_group.sgr.id]
  subnet_id = aws_subnet.pv_sub.id
}