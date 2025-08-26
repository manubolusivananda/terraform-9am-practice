
resource "aws_vpc" "name" {
  cidr_block = var.cidr_block_vpc
  tags = {
    Name = "vpc"
  }
}
resource "aws_subnet" "pub_sub_1" {
  vpc_id = aws_vpc.name.id
  cidr_block = var.cidr_block_pub_sub_1
  availability_zone = "us-east-2a"
}
resource "aws_subnet" "pub_sub_2" {
  vpc_id = aws_vpc.name.id
  cidr_block = var.cidr_block_pub_sub_2
  availability_zone = "us-east-2b"
}
resource "aws_subnet" "pvt_1" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.cidr_block_pvt_1
    availability_zone = "us-east-2b"
}
resource "aws_subnet" "pvt_2" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.cidr_block_pvt_2
    availability_zone = "us-east-2a" 
  
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.name.id
  
}
resource "aws_eip" "el" {
    domain = "vpc"
  
}
resource "aws_nat_gateway" "ngw" {
    subnet_id = aws_subnet.pub_sub_1.id
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
  for_each       = {
    pub1 = aws_subnet.pub_sub_1.id
    pub2 = aws_subnet.pub_sub_2.id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.pub_rt.id
}
resource "aws_route_table" "pvrt" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "private-rt"
  }
}
resource "aws_route_table_association" "pvt_ass" {
  for_each = {
    pvt1 = aws_subnet.pvt_1.id
    pvt2 = aws_subnet.pvt_2.id
  }

  subnet_id      = each.value
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
    from_port = 3306
    to_port = 3306
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
    subnet_id = aws_subnet.pub_sub_1.id
    vpc_security_group_ids = [aws_security_group.sgr.id]
    associate_public_ip_address = true
    tags = {
      Name = "public-server"
   
    }                
}
  
resource "aws_instance" "pv_server_1" {
  ami = var.ami_id2
  instance_type = var.type2
  vpc_security_group_ids = [aws_security_group.sgr.id]
  subnet_id = aws_subnet.pvt_1.id
   tags = {
      Name = "private-server-1"
   
    }  
}
resource "aws_instance" "pv_server_2" {
  ami = var.ami_id3
  instance_type = var.type3
  vpc_security_group_ids = [aws_security_group.sgr.id]
  subnet_id = aws_subnet.pvt_2.id  
  tags = {
      Name = "private-server-2"
   
    } 

}
resource "aws_db_subnet_group" "subnet_group" {
    name = "dev-db-subnet-group"
    subnet_ids = [aws_subnet.pvt_1.id,aws_subnet.pvt_2.id]
    tags = {
      Name = "subnet-group"
    }
  
}
# crate of rds instance
resource "aws_db_instance" "rds" {
    identifier = "database-3"
    engine = "mysql"
    engine_version = "8.0.42"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    db_name = "sivards"
    username = "admin"
    password = "siva123456"
    db_subnet_group_name = aws_db_subnet_group.subnet_group.name # subnetgroup we  are calling by using name not id
    vpc_security_group_ids = [aws_security_group.sgr.id]
    publicly_accessible = false
    skip_final_snapshot = true #before instance delete not do backup snapshot
    deletion_protection = false #you can delete resource true means we cannot delete
    multi_az = false #standby db not create in multi_az true means create
    backup_retention_period = 7
    tags = {
      Name = "sivananda-database"
    }
    


}

