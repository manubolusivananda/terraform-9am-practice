resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
  
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
  
}
# | Terraform Command     | OpenTofu Equivalent |
# | --------------------- | ------------------- |
# | `terraform init`      | `tofu init`         |
# | `terraform plan`      | `tofu plan`         |
# | `terraform apply`     | `tofu apply`        |
# | `terraform destroy`   | `tofu destroy`      |
# | `terraform validate`  | `tofu validate`     |
# | `terraform fmt`       | `tofu fmt`          |
# | `terraform show`      | `tofu show`         |
# | `terraform output`    | `tofu output`       |
# | `terraform providers` | `tofu providers`    |





#winget install --exact --id=OpenTofu.Tofu
#tofu -version

#not working means
# manub@MANUBOLU MINGW64 ~/Downloads/TERRAFORM-PRACTICE (master)
# $ cd terraform-9am-practice/

# manub@MANUBOLU MINGW64 ~/Downloads/TERRAFORM-PRACTICE/terraform-9am-practice (main)
# $ vi ~/.bashrc
# add this inside above one export PATH=$PATH:/c/Users/manub/AppData/Local/Microsoft/WinGet/Packages/OpenTofu.Tofu_Microsoft.Winget.Source_8wekyb3d8bb

# manub@MANUBOLU MINGW64 ~/Downloads/TERRAFORM-PRACTICE/terraform-9am-practice (main)
# $ source ~/.bashrc

# manub@MANUBOLU MINGW64 ~/Downloads/TERRAFORM-PRACTICE/terraform-9am-practice (main)
# $ tofu version
# OpenTofu v1.10.5
# on windows_amd64
