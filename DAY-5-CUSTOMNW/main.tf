#creation of vpc
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags =  {
        Name = "vpc"
    }
}
#creation of subnets
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    availability_zone = "us-west-1a"
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "subnet"
    }
}
#creation of ig
resource "aws_internet_gateway" "name" {
   vpc_id = aws_vpc.name.id
   tags = {
     name="igw"
   }

}
#creation of route table and editroutes
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
    tags = {
      name= "rt"
    }
    
}
#creation of subnet association
resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.name.id
  route_table_id = aws_route_table.name.id
  
}
#creation of sg group
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
#creation of  public server 
resource "aws_instance" "name" {
  ami = "ami-06e11c4cc68c362dd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sgr.id]
  subnet_id = aws_subnet.name.vpc_id
}