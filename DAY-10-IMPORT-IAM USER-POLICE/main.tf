provider "aws" {
  
}
resource "aws_iam_user" "user" {
  name = "user"

  tags = {
    Name = "user"
  }
}

resource "aws_iam_user_policy_attachment" "siva_readonly" {
  user       = aws_iam_user.user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
