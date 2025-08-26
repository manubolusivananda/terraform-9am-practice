provider "aws" {
  
}
resource "aws_key_pair" "key" {
  key_name   = "siva"
  public_key = file("C:/Users/manub/.ssh/id_ed25519.pub")
}
resource "aws_instance" "name" {
  ami           = "ami-0b016c703b95ecbe4" # use a valid ece AMI for your region
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name
  tags = {
    Name = "ec2"
  }

  # provisioner "file" {
  #   source      = "file10"
  #   destination = "/home/ec2-user/file10"
  # }

  # connection {
  #   type        = "ssh"
  #   user        = "ec2-user"
  #   private_key = file("C:/Users/manub/.ssh/id_ed25519") #  In this  location path C:/Users/manub/  we can use "~" tilt
  #   host        = self.public_ip
  # }
  # provisioner "remote-exec" {
  #       inline = [
  #           "touch /home/ec2-user/file200",
  #           " echo 'hello aws this ganesh ' >>  /home/ec2-user/file200"
  #       ]
  #   }
  #   provisioner "local-exec" {
  #   command = "echo 'Hello from local-exec!' > file400.txt"
  # }
}
resource "null_resource" "name" {     #only provisionar block recreate means new changes update instance is not destory
  provisioner "file" {
    source      = "file10"
    destination = "/home/ec2-user/file10"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/manub/.ssh/id_ed25519") #  In this  location path C:/Users/manub/  we can use "~" tilt
    host        = aws_instance.name.public_ip
  }
  provisioner "remote-exec" {
        inline = [
            "touch /home/ec2-user/file200",
            " echo 'hello aws this nanda ' >>  /home/ec2-user/file200"
        ]
    }
    provisioner "local-exec" {
    command = "echo 'Hello from local-exec!' > file400.txt"
  }
  triggers = {
    always_run = "${timestamp()}" # Forces rerun every time
  }

}
#Solution-2 to Re-Run the Provisioner
#Use terraform taint to manually mark the resource for recreation:
# terraform taint aws_instance.server # taint means instance delete and create 
# terraform init
# terraform apply
  
