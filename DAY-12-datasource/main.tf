data "aws_sunet" "name" { #data source is used to already created resource to use
    filter {
        name = "tag:name"
        values = ["dev"] #this subnet already created in aws just we calling through  data source that subnet to use present creating resource
    }
}
resource "aws_instance" "name" {
    ami = "ami-0b016c703b95ecbe4"
    instance_type = "t2.micro"
    subnet_id = data.aws_sunet.name.id # the data source inside  subnet we calling her, so we no need to create vpc also here already create in aws.
}   
data "aws_id" "id" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = [ "amzn2-ami-hvm-*-gp2"]
    
    }
    filter {
        name = "root-device-type" # filter type which type we have to filter 
        value = ["eds"]

    }
    filter {
        name = "vartuvalizatio-type" 
        values = ["hvm"]

    }
    filter {
        name = "architecture "
        value = ["x86_64"]
    }

}
# default ami's calling through data source
resource "aws_instance" "name" {
    ami = data.aws_id.id
    instance_type = "t2.micro"
}

 # manully  create image  and taking ami-id through data-source
data "aws_id" "name" {
    most_recent = true
    owner = "self"
    filter {
        name = "name"
        value = ["frontend-ami"]
    }
}


