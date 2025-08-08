resource "aws_instance" "name" {
  ami                  = "ami-0d1891272a8f97fb4"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.rds_instance_profile.name

  tags = {
    Name = "devtest"
  }
}

resource "aws_iam_role" "rds_permission" {
  name = "rds-permission"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach AmazonRDSFullAccess managed policy to the role
resource "aws_iam_role_policy_attachment" "rds_full_access" {
  role       = aws_iam_role.rds_permission.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_instance_profile" "rds_instance_profile" {
  name = "rds_instance_profile"
  role = aws_iam_role.rds_permission.name
}

