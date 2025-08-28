# provider "aws" {
#   region = "us-east-2" # change if needed
# }

# # Get the default VPC
# data "aws_vpc" "default" {
#   default = true
# }

# # Get all default subnets inside that VPC
# data "aws_subnets" "default" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.default.id]
#   }
# }

# # Launch EC2 instance in the first default subnet
# resource "aws_instance" "example" {
#   ami           = "" # use correct AMI for your region
#   instance_type = "t2.micro"
#   subnet_id     = data.aws_subnets.default.ids[2] # pick first default subnet

#   tags = {
#     Name = "My-EC2-From-Default-Subnet"
#   }
# }


# data "aws_id" "id" {
#     most_recent = true
#     owners = ["amazon"]
#     filter {
#         name = "name"
#         values = [ "amzn2-ami-hvm-*-gp2"]
    
#     }
#     filter {
#         name = "root-device-type" # filter type which type we have to filter 
#         value = ["eds"]

#     }
#     filter {
#         name = "vartuvalizatio-type" 
#         values = ["hvm"]

#     }
#     filter {
#         name = "architecture "
#         value = ["x86_64"]
#     }

# }
# default ami's calling through data source


# resource "aws_instance" "name" {
#     ami = data.aws_ami.name.id
#     instance_type = "t2.micro"
    
# }

#  # manully  create image  and taking ami-id through data-source
# data "aws_ami" "name" {
#     most_recent = true
#     owners = ["self"]
#     filter {
#         name = "name"
#         values = ["frontend-ami"]
#     }
# }
data "aws_subnet" "name" { #data source is used to already created resource to use
    filter {
        name = "tag:Name"
        values = ["datasubnet"] #this subnet already created in aws just we calling through  data source that subnet to use present creating resource
    }
}
resource "aws_instance" "name" {
    ami = "ami-0b016c703b95ecbe4"
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.name.id # the data source inside  subnet we calling her, so we no need to create vpc also here already create in aws.
}  

