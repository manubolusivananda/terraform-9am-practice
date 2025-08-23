provider "aws" {
  region = "ap-south-1"
}

# Create IAM user
resource "aws_iam_user" "admin_user" {
  name = "nanda"
}

# Attach AdministratorAccess policy to the user
resource "aws_iam_user_policy_attachment" "admin_attach" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
