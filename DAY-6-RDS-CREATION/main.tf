provider "aws" {
  
}
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "vpc"
    }
  
}
resource "aws_subnet" "pvt_1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
  
}
resource "aws_subnet" "pvt_2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b" 
  
}
resource "aws_db_subnet_group" "subnet_group" {
    name = "dev-db-subnet-group"
    subnet_ids = [aws_subnet.pvt_1.id,aws_subnet.pvt_2.id]
    tags = {
      Name = "subnet-group"
    }
  
}
resource "aws_security_group" "sg_r"{
    name = "rds-sg"
    description = "Allow" 
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "sg"
    }
    # inbound allow
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # outbound
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
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
    vpc_security_group_ids = [aws_security_group.sg_r.id]
    publicly_accessible = false
    skip_final_snapshot = true #before instance delete not do backup snapshot
    deletion_protection = false #you can delete resource true means we cannot delete
    multi_az = false #standby db not create in multi_az true means create
    backup_retention_period = 7
    tags = {
      Name = "sivananda-database"
    }
    


}
#create  a readreplica 
resource "aws_db_instance" "read_replica" {
    identifier = "database-2"
    replicate_source_db = aws_db_instance.rds.identifier
    instance_class = "db.t3.micro"
    publicly_accessible = false
    auto_minor_version_upgrade = true
    skip_final_snapshot = true
    deletion_protection = false
    vpc_security_group_ids = [aws_security_group.sg_r.id]
    depends_on =  [aws_db_instance.rds]
    tags = {
      Name = "sivareadreplica"
    }

  
}
