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
